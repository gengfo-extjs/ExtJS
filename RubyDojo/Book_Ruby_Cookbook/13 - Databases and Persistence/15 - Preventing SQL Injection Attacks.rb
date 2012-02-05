use cookbook;

DROP TABLE IF EXISTS names;
CREATE TABLE names (
  first VARCHAR(200),
  last VARCHAR(200)
) ENGINE=InnoDB;

INSERT INTO names values ('Leonard', 'Richardson'), 
                         ('Lucas', 'Carlson'), 
                         ('Michael', 'Loukides');
#---
#!/usr/bin/ruby
# no_sql_injection.rb
require 'cookbook_dbconnect'

print 'Enter a last name to search for: '
search_for = readline.chomp
with_db do |db|
  sql = 'select first, last from names where last=?'
  db.execute(sql, [search_for]).fetch_hash do |r|
    puts %{Matched "#{r['first']} #{r['last']}"}
  end
end
#---
$ ruby no_sql_injection.rb
Enter a last name to search for: Richardson
Matched "Leonard Richardson"

# See the Discussion if you're not sure how this attack is supposed to work.
$ ruby no_sql_injection.rb
Enter a last name to search for: " or 1=1
#---
#!/usr/bin/ruby
# sql_injection.rb
require 'cookbook_dbconnect'

print "Enter a last name to search for: "
search_for = readline.chomp
query = %{select first, last from names where last="#{search_for}"}
puts query if $DEBUG
with_db do |db|
  db.execute(query).fetch_hash do |r|
    puts %{Matched "#{r['first']} #{r['last']}"}
  end
end
#---
$ ruby -d sql_injection.rb
Enter a last name to search for: Richardson
select first_name, last_name from people where last_name="Richardson"
Matched "Leonard Richardson"
#---
$ ruby -d sql_injection.rb
Enter a last name to search for: " or 1=1
select first_name, last_name from people where last_name="" or 1=1"
Matched "Leonard Richardson"
Matched "Lucas Carlson"
Matched "Michael Loukides"
#---
require 'cookbook_dbconnect'
activerecord_connect

class Name < ActiveRecord::Base
  def self.by_last(name)
    find_all ["last = ?", name]
  end
end

Name.by_last("Richardson").size              # => 1
Name.by_last(%{" or 1=1}).size               # => 0
#---
class Name 
  def self.by_last(name)
    find_all ["last = :last", {:last => name}]
  end
end

Name.by_last("Richardson").size              # => 1
#---
