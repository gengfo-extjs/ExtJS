require 'rubygems'
require 'mysql'

def with_db
  dbh = Mysql.real_connect('localhost', 'cookbook_user', 'password', 
	                   'cookbook')
  begin
    yield dbh	
  ensure
    dbh.close
  end
end
#---
with_db do |db|
  db.query('drop table if exists secrets')
  db.query('create table secrets( id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                   secret LONGTEXT )')
  db.query(%{insert into secrets(secret) values 
     ("Oh, MySQL, you're the only one who really understands me.")})
end
#---
with_db do |db|
  res = db.query('select * from secrets')
  res.each { |row| puts "#{row[0]}: #{row[1]}" }
  res.free
end
# 1: Oh, MySQL, you're the only one who really understands me.
#---
class Mysql
  alias :query_no_block :query
  def query(sql)
    res = query_no_block(sql)
    return res unless block_given?
    begin
      yield res
    ensure
      res.free if res
    end
  end
end
#---
with_db do |db| 
  db.query('select * from secrets') do |res|
    res.each { |row| puts "#{row[0]}: #{row[1]}" }
  end
end
# 1: Oh, MySQL, you're the only one who really understands me.
#---
with_db do |db|
  db.query('select * from secrets') do |res|
    puts "#{res.num_rows} row(s) matched:"
    res.each_hash do |hash|
      hash.each { |k,v| puts " #{k} = #{v}" }
    end
  end
end
# 1 row(s) matched:
#  id = 1
#  secret = Oh, MySQL, you're the only one who really understands me.
#---
