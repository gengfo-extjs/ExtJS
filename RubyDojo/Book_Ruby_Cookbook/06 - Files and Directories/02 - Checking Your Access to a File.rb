File.readable?('/bin/ls')                # => true
File.readable?('/etc/passwd-')           # => false

filename = 'test_file'
File.open(filename, 'w') {}
File.writable?(filename)                 # => true
File.writable?('/bin/ls')                # => false

File.executable?('/bin/ls')              # => true
File.executable?(filename)               # => false
#---
File.owned? 'test_file'                  # => true
File.grpowned? 'test_file'               # => true
File.owned? '/bin/ls'                    # => false
#---
File.lstat('test_file').mode & 0777       # Keep only the permission bits.
# => 420                                  # That is, 0644 octal.
#---
def what_can_i_do?
  sys = Process::Sys	
  puts "UID=#{sys.getuid}, GID=#{sys.getgid}"
  puts "Effective UID=#{sys.geteuid}, Effective GID=#{sys.getegid}"

  file = '/bin/ls'
  can_do = [:readable?, :writable?, :executable?].inject([]) do |arr, method|
    arr << method if File.send(method, file); arr
  end
  puts "To you, #{file} is: #{can_do.join(', ')}"
end
#---
what_can_i_do?
# UID=0, GID=0
# Effective UID=0, Effective GID=0
# To you, /bin/ls is: readable?, writable?, executable?

Process.uid = 1000
what_can_i_do?
# UID=0, GID=0
# Effective UID=1000, Effective GID=0
# To you, /bin/ls is: readable?, executable?
#---
