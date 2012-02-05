def confirmation_hearings
  questions = [['What is your name?', :name],
               ['How old are you?', :age],
               ['Why would you like to be Secretary of the Treasury?', :why]]
  answers = questions.inject({}) do |answers, qv|
    question, value = qv
    print question + ' '
    answers[value] = gets.chomp
    answers
  end
  puts "Okay, you're confirmed!"
  return answers
end

confirmation_hearings
# What is your name?                                  # <= Leonard Richardson
# How old are you?                                    # <= 27
# Why would you like to be Secretary of the Treasury? # <= Mainly for the money
# Okay, you're confirmed!
# => {:age=>"26", :why=>"Mainly for the money", :name=>"Leonard Richardson"}
#---
$ ./confirmation_hearings.rb < answers
# => What is your name? How old are you? Why would you like to be 
#    Secretary of the Treasury? Okay, you're confirmed!
#---
require 'rubygems'
require 'highline/import'

def confirmation_hearings
  answers = {}
  answers[:name] = ask('What is your name? ')
  answers[:age] = ask('How old are you? ', Integer) { |q| q.in = 0..120 }
  answers[:why] = ask('Why would you like to be Secretary of the Treasury? ')
  puts "Okay, you're confirmed!"
  return answers
end

confirmation_hearings
# What is your name?                                  # <= Leonard Richardson
# How old are you?                                    # <= twenty-seven
# You must enter a valid Integer.
# ?                                                   # <= 200
# Your answer isn't within the expected range (included in 0..120)
# ?                                                   # <= 27
# ...
#---
