def run(command, input='')
  IO.popen(command, 'r+') do |io|
    io.puts input
    io.close_write
    return io.read
  end
end

run 'wc -w', 'How many words are in this string?'         # => "7\n"
#---
print 'Enter your password for sudo: '
sudo_password = gets.chomp
run('sudo apachectl graceful', user_password)
#---
require 'expect'
require 'pty'

print 'Old password:'
old_pwd = gets.chomp
print "\nNew password:"
new_pwd = gets.chomp

PTY.spawn('passwd') do |read,write,pid|
  write.sync = true
  $expect_verbose = false
  
  # If 30 seconds pass and the expected text is not found, the
  # response object will be nil.
  read.expect("(current) UNIX password:", 30) do |response|
    write.print old_pwd + "\n" if response
  end
  
  # You can use regular expressions instead of strings. The code block
  # will give you the regex matches.
  read.expect(/UNIX password: /, 2) do |response, *matches|
    write.print new_pwd + "\n" if response
  end

  # The default value for the timeout is 9999999 seconds
  read.expect("Retype new UNIX password:") do |response| 
   write.puts new_pwd + "\n" if response
  end
end
#---
