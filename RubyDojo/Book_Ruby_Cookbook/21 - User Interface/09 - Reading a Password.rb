require 'rubygems'
require 'highline/import'

def get_password(prompt='Password: ')
  ask(prompt) { |q| q.echo = false}
end

get_password("What's your password? ")
# What's your password?
# => "buddy"
#---
def get_password(prompt='Password: ', mask='*')
  ask(prompt) { |q| q.echo = mask }
end

get_password
# Password: *****
# => "buddy"

get_password('Password: ', false)
# Password:
# => "buddy"
#---
