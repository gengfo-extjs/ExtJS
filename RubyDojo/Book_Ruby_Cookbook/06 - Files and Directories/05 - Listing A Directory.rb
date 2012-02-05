# See the chapter intro for the create_tree library
require 'create_tree'
create_tree 'mydir' => 
  [ {'subdirectory' => [['file_in_subdirectory', 'Just a simple file.']] },
    '.hidden_file', 'ruby_script.rb', 'text_file' ]
   
Dir.entries('mydir')

# => [".", "..", ".hidden_file", "ruby_script.rb", "subdirectory", 
#     "text_file"]

Dir.foreach('mydir') { |x| puts x if x != "." && x != ".."}

# .hidden_file
# ruby_script.rb

# subdirectory

# text_file
#---
# Find all the "regular" files and subdirectories in mydir. This excludes
# hidden files, and the special directories . and ..
Dir["mydir/*"]
# => ["mydir/ruby_script.rb", "mydir/subdirectory", "mydir/text_file"]

# Find all the .rb files in mydir
Dir["mydir/*.rb"]                  # => ["mydir/ruby_script.rb"]
#---
Dir.open('mydir') { |d| d.grep /file/ }
# => [".hidden_file", "text_file"]

Dir.open('mydir') { |d| d.each { |x| puts x } }
# .
# ..

# .hidden_file

# ruby_script.rb

# subdirectory

# text_file
#---
#Get all contents other than ".", "..", and hidden files.

d = Dir.open('mydir')
d.reject { |f| f[0] == '.' }
# => ["subdirectory", "ruby_script.rb", "text_file"]

#Now the Dir object is useless until we call Dir#rewind.
d.entries.size                                      # => 0
d.rewind
d.entries.size                                      # => 6

#Get the names of all files in the directory.
d.rewind
d.reject { |f| !File.file? File.join(d.path, f) }
# => [".hidden_file", "ruby_script.rb", "text_file"]

d.close
#---
def File.from_dir(dir, name)
  dir = dir.path if dir.is_a? Dir
  path = File.join(dir, name)
  (File.directory?(path) ? Dir : File).open(path) { |f| yield f }
end
#---
File.from_dir("mydir", "subdirectory") do |subdir|
 File.from_dir(subdir, "file_in_subdirectory") do |file|
    puts %{My path is #{file.path} and my contents are "#{file.read}".}
  end
end
# My path is mydir/subdirectory/file_in_subdirectory and my contents are 
# "Just a simple file".
#---
Dir["mydir/**/*"]

# => ["mydir/ruby_script.rb", "mydir/subdirectory", "mydir/text_file",
#     "mydir/subdirectory/file_in_subdirectory"]

Dir["mydir/**/*file*"]
# => ["mydir/text_file", "mydir/subdirectory/file_in_subdirectory"]
#---
#Regex-style character classes
Dir["mydir/[rs]*"]    # => ["mydir/ruby_script.rb", "mydir/subdirectory"]
Dir["mydir/[^s]*"]    # => ["mydir/ruby_script.rb", "mydir/text_file"]

# Match any of the given strings
Dir["mydir/{text,ruby}*"]  # => ["mydir/text_file", "mydir/ruby_script.rb"]

# Single-character wildcards
Dir["mydir/?ub*"]     # => ["mydir/ruby_script.rb", "mydir/subdirectory"]

#---
Dir["mydir/.*"]       # => ["mydir/.", "mydir/..", "mydir/.hidden_file"]
#---
