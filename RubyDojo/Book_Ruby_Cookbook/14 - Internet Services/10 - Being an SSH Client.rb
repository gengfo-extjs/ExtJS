require 'rubygems'
require 'net/ssh'

Net::SSH.start('example.com', :username=>'leonardr',
               :password=>'mypass') do |session|
  # Manipulate your Net::SSH::Session object here...
end
#---
Net::SSH.start('example.com', :username=>'leonardr',
               :password=>'mypass') do |session|
  cmd = 'ls -l /home/leonardr/test_dir'
  session.process.popen3(cmd) do |stdin, stdout, stderr|
    puts stdout.read
  end
end
# -rw-rw-r--    1 leonardr leonardr       33 Dec 29 20:40 file1
# -rw-rw-r--    1 leonardr leonardr      102 Dec 29 20:40 file2
#---
Net::SSH.start('example.com', :username=>'leonardr',
               :password=>'mypass') do |session|
  shell = session.shell.sync
  puts "Original working directory: #{shell.pwd.stdout}"
  shell.cd 'test_dir'
  puts "Working directory now: #{shell.pwd.stdout}"
  puts 'Directory contents:'
  puts shell.ls("-l").stdout
  shell.exit
end
# Original working directory: /home/leonardr
# Working directory now: /home/leonardr/test_dir
# Directory contents:
# -rw-rw-r--    1 leonardr leonardr       33 Dec 29 20:40 file1
# -rw-rw-r--    1 leonardr leonardr      102 Dec 29 20:40 file2
#---
