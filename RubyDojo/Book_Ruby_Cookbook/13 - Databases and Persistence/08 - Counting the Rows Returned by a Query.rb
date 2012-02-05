require 'cookbook_dbconnect'

with_db do |c|
  c.do %{drop table if exists letters}
  c.do %{create table letters(id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          letter CHAR(1) NOT NULL)}
  letter_sql = ('a'..'z').collect.join('"),("')
  c.do %{insert into letters(letter) values ("#{letter_sql}")}
end
# => 26
#---
vowel_query = %{select id from letters where letter in ("a","e","i","o","u")}
with_db do |c|
  h = c.execute vowel_query
  "My collection contains #{h.rows} vowels."
end
# => "My collection contains 5 vowels."
#---
with_db do |c|
  vowels = c.select_all(vowel_query)
  "My collection still contains #{vowels.size} vowels."
end
# => "My collection still contains 5 vowels."
#---
with_db do |c|
  rows = 0
  c.execute(vowel_query).each do |row|
    rows += 1
    # Process the row...
  end
  "Yup, all #{rows} vowels are still there."
end
# => "Yup, all 5 vowels are still there."
#---
module DBI
  class DatabaseHandle
    def execute_with_count(query, *args)
      re = /^\s*select .* from/i
      count_query = query.sub(re, 'select count(*) from')
      count = select_one(count_query)
      [count, execute(query)]
    end
  end
end

with_db do |c|
  count, handle = c.execute_with_count(vowel_query)
  puts "I can't believe none of the #{count} vowels " + 
	"have been stolen from my collection!"

  puts 'Here they are in the database:'
  handle.each do |r|
    puts "Row #{r['id']}"
  end
end
# I can't believe none of the 5 vowels have been stolen from my collection!
# Here they are in the database:
# Row 1
# Row 5
# Row 9
# Row 15
# Row 21
#---
