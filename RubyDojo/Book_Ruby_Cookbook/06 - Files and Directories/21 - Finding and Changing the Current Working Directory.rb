Dir.getwd                            # => "/home/leonardr"
#---
Dir.chdir("/bin")
Dir.getwd                           # => "/bin"
File.exists? "ls"                   # => true
#---
