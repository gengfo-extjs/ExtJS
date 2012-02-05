require 'rubygems'
require 'postgres'

def with_db
  db = PGconn.connect('localhost', 5432, '', '', 'cookbook',
                      'cookbook_user', 'password')
  begin
    yield db
  ensure
    db.close
  end
end
#---
with_db do |db|
  begin
    db.exec('drop table secrets')
  rescue PGError
    # Unlike MySQL, Postgres does not have a "drop table unless exists"
    # command. We can simulate it by issuing a "drop table" command and
    # ignoring any error due to the table not existing in the first place.
    # This is essentialy what MySQL's "drop table unless exists" does.
  end

  db.exec('create table secrets( id SERIAL PRIMARY KEY,
                                 secret TEXT )')
  db.exec(%{insert into secrets(secret) values 
            ('Oh, Postgres, you\\'re the only one who really understands me.')})
end
#---
with_db do |db|
  res = db.query('select * from secrets')
  res.each { |row| puts "#{row[0]}: #{row[1]}" }
end
# 1: Oh, Postgres, you're the only one who really understands me.
#---
class PGconn
  alias :exec_no_block :exec
  def exec(sql)
    res = exec_no_block(sql)
    return res unless block_given?
    begin
      yield res
    ensure
      res.clear if res
    end
  end
end
#---
with_db do |db| 
  db.exec('select * from secrets') do |res|
    res.each { |row| puts "#{row[0]}: #{row[1]}" }    
  end
end
# 1: Oh, Postgres, you're the only one who really understands me.
#---
class PGresult
  def each_hash
    f = fields
    each do |array|
      hash = {}
      fields.each_with_index do |field, i|
        hash[field] = array[i]
      end
      yield hash
    end   
  end
end
#---
with_db do |db|
  db.exec("select * from secrets") do |res|
    puts "#{res.num_tuples} row(s) matched:"
    res.each_hash do |hash|
      hash.each { |k,v| puts " #{k} = #{v}" }
    end
  end
end
# 1 row(s) matched:
#  id = 1
#  secret = Oh, Postgres, you're the only one who really understands me.
#---
