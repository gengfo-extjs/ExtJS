%x{ls no_such_directory}
# ls: no_such_directory: No such file or directory
#---
require 'open3'

Open3.popen3('ls -l no_such_directory') { |stdin, stdout, stderr| stderr.read }
# => "ls: no_such_directory: No such file or directory\n"
#---
