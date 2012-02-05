def rescue_and_retry
  error_fixed = false
  begin
    puts 'I am before the raise in the begin block.'
    raise 'An error has occurred!' unless error_fixed
    puts 'I am after the raise in the begin block.'
  rescue
    puts 'An exception was thrown! Retrying...'
    error_fixed = true
    retry    
  end
  puts 'I am after the begin block.'
end

rescue_and_retry
# I am before the raise in the begin block.
# An exception was thrown! Retrying...
# I am before the raise in the begin block.
# I am after the raise in the begin block.
# I am after the begin block.
#---
require 'open-uri'

def check_connection(max_tries=2, url='http://www.ruby-lang.org/')
  tries = 0
  begin
    tries += 1
    puts 'Checking connection...'
    open(url) { puts 'Connection OK.' }
  rescue Exception
    puts 'Connection not OK!'
    retry unless tries >= max_tries
  end
end

check_connection
# Checking connection...
# Connection OK.

check_connection(2, 'http://this.is.a.fake.url/')
# Checking connection...
# Connection not OK!
# Checking connection...
# Connection not OK!
#---
