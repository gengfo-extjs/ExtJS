require 'find'
module Find
  def match(*paths)
    matched = []
    find(*paths) { |path| matched << path if yield path }
    return matched
  end
  module_function :match
end
#---
require 'create_tree'
create_tree './' => 
  [ { 'Music' => ['cancelled_download.MP3', 
                  ['The Snails - Red Rocket.mp3', 'Song contents #1'],
                  ['The Snails - Moonfall.mp3', 'Song contents #2'] 
                 ]
    },
    { 'tmp' => ['empty1', 'empty2', ['README', 'Hi there!']] },
    { 'rubyprog-0.1' => [['rubyprog.rb', '#!/usr/bin/env ruby'], 
                         ['README', 'This Ruby program is great!']
                        ]
    }
  ]

#---
# Find the empty files.
Find.match('./') { |p| File.lstat(p).size == 0 }

# => ["./tmp/empty2", "./tmp/empty1", "./Music/cancelled_download.MP3"]

# Find the MP3s.
Find.match('./') { |p| ext = p[-4...p.size]; ext && ext.downcase == '.mp3' }
# => ["./Music/The Snails - Red Rocket.mp3", 
#     "./Music/The Snails - Moonfall.mp3", 
#     "./Music/cancelled_download.MP3"]


# Find the README files.
Find.match('./') { |p| File.split(p)[1] == 'README' }
# => ["./tmp/README", "./rubyprog-0.1/README"]
#---
Find.match('./') do |p| 
  Find.prune if p == "./tmp"  
  File.split(p)[1] == "README"
end
# => ["./rubyprog-0.1/README"]
#---
must_start_with = "This Ruby program"
Find.match('./') do |p|
  if File.file? p
    open(p) { |f| f.read(must_start_with.size) == must_start_with }
  else
    false
  end
end
# => ["./rubyprog-0.1/README"]
#---
# Finds files that were probably left behind by emacs sessions.
def emacs_droppings(*paths)
  Find.match(*paths) do |p| 
    (p[-1] == ?~ and p[0] != ?~) or (p[0] == ?# and p[-1] == ?#)
  end
end

# Finds all files that are larger than a certain threshold. Use this to 
# find the files hogging space on your filesystem.
def bigger_than(bytes, *paths)
  Find.match(*paths) { |p| File.lstat(p).size > bytes }  
end

# Finds all files modified more recently than a certain number of seconds 
# ago.
def modified_recently(seconds, *paths)
  time = Time.now - seconds
  Find.match(*paths) { |p| File.lstat(p).mtime > time }  
end

# Finds all files that haven't been accessed since they were last modified.
def possibly_abandoned(*paths)
  Find.match(*paths) { |p| f = File.lstat(p); f.mtime == f.atime }
end
#---
