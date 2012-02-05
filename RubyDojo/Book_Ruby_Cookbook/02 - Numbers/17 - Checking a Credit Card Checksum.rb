require 'rubygems'
require 'creditcard'

'5276 4400 6542 1319'.creditcard?                  # => true
'5276440065421313'.creditcard?                     # => false
1276440065421319.creditcard?                       # => false
#---
5276440065421313.creditcard_type                   # => "mastercard"
#---
module CreditCard
  def creditcard?
    numbers = self.to_s.gsub(/[^\d]+/, '').split(//)
    
    checksum = 0
    0.upto numbers.length do |i|
      weight = numbers[-1*(i+2)].to_i * (2 - (i%2))
      checksum += weight % 9
    end
    
    return numbers[-1].to_i == 10 - checksum % 10
  end
end

class String
  include CreditCard
end

class Integer
  include CreditCard
end

'5276 4400 6542 1319'.creditcard?                  # => true
#---
numbers = '5276 4400 6542 1319'.gsub(/[^\d]+/, '').split(//)
# => 	["5", "2", "7", "6", "4", "4", "0", "0", 
# =>     "6", "5", "4", "2", "1", "3", "1", "9"]
#---
checksum = 0
0.upto numbers.length do |i|
  weight = numbers[-1*(i+2)].to_i * (2 - (i%2))
  checksum += weight % 9
end
checksum                                            # => 51
#---
numbers[-1].to_i == 10 - checksum % 10             # => true
#---
