h = {}
h[:name] = "Robert"
h[:nickname] = "Bob"
h[:age] = 43
h[:email_addresses] = {:home => "bob@example.com", 
                       :work => "robert@example.com"}
h
# => {:email_addresses=>["bob@example.com", "robert@example.com"], 
#      :nickname=>"Bob", :name=>"Robert", :age=>43}
puts h
# nicknameBobage43nameRobertemail_addresseshomebob@example.comworkrobert@example.com
puts h[:email_addresses]
# homebob@example.comworkrobert@example.com
#---
p h[:email_addresses]
# {:home=>"bob@example.com", :work=>"robert@example.com"}
#---
p h
# {:nickname=>"Bob", :age=>43, :name=>"Robert", :email_addresses=>{:home=>"bob@example.com", :work=>"robert@example.com"}}
#---
require 'pp'
pp h[:email_addresses]
# {:home=>"bob@example.com", :work=>"robert@example.com"}

pp h
# {:email_addresses=>{:home=>"bob@example.com", :work=>"robert@example.com"},
#  :nickname=>"Bob",
#  :name=>"Robert",
#  :age=>43}
#---
PP::pp(h, $stderr, 50)
# {:nickname=>"Bob",
#  :phone_numbers=>
#   {:cell=>"(555) 555-5557",
#    :home=>"(555) 555-5555",
#    :fax=>"(555) 555-1234",
#    :work=>"(555) 555-5556"},
#  :email_addresses=>
#   {:home=>"bob@example.com",
#   :work=>"robert@example.com"},
#  :age=>43,
#  :name=>"Robert"}
# => #<IO:0x2c8cc>
#---
require 'yaml'
puts h.to_yaml
# --- 
# :nickname: Bob
# :age: 43
# :name: Robert
# :email_addresses:
#   :home: bob@example.com
#   :work: robert@example.com
#---
h[:email_addresses].each do |key, val|
  puts "#{key} => #{val}"
end
# home => bob@example.com
# work => robert@example.com
#---
