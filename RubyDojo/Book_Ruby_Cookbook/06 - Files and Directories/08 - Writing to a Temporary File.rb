require 'tempfile'
out = Tempfile.new("tempfile")
out.path                            # => "/tmp/tempfile23786.0"
#---
out << "Some text."
out.rewind
out.read                             # => "Some text."
out.close
#---
out = Tempfile.new("myhome_tempfile", "/home/leonardr/temp/")
#---
require 'fileutils'
FileUtils.mv(out.path, "/home/leonardr/old_tempfile")
#---
