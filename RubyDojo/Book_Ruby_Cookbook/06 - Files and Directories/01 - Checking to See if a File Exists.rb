filename = 'a_file.txt'
File.file? filename                        # => false

require 'fileutils'
FileUtils.touch(filename)
File.file? filename                        # => true
#---
directory_name = 'a_directory'
FileUtils.mkdir(directory_name)
File.file? directory_name                    # => false
File.exists? directory_name                  # => true
#---
File.directory? directory_name                 # => true
File.directory? filename                       # => false
#---
File.blockdev? '/dev/hda1'                   # => true
File.chardev? '/dev/tty1'                    # => true
File.socket? '/var/run/mysqld/mysqld.sock'   # => true
system('mkfifo named_pipe')
File.pipe? 'named_pipe'                      # => true
#---
new_filename = "#{filename}2"
File.symlink(filename, new_filename)

File.symlink? new_filename                  # => true
File.file? new_filename                     # => true
#---
