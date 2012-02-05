require 'create_tree'
create_tree './' => 
  [ 'file1', 
    'file2',
    { 'subdir1/' => [ 'file1' ] },
    { 'subdir2/' => [ 'file1',
                      'file2',
                      { 'subsubdir/' => [ 'file1' ] } 
                    ] 
    } 
  ]
#---
Dir['**/**']
# => ["file1", "file2", "subdir1", "subdir2", "subdir1/file1", 
#     "subdir2/file1", "subdir2/file2", "subdir2/subsubdir", 
#     "subdir2/subsubdir/file1"]
#---
require 'find'
Find.find('./') { |path| puts path }
# ./
# ./subdir2
# ./subdir2/subsubdir
# ./subdir2/subsubdir/file1

# ./subdir2/file2
# ./subdir2/file1

# ./subdir1
# ./subdir1/file1
# ./file2
# ./file1
#---
Find.find('./') do |path| 
  Find.prune if File.basename(path) == 'subdir2'
  puts path
end
# ./
# ./subdir1
# ./subdir1/file1
# ./file2
# ./file1
#---
Find.find('./') do |path| 
  if File.basename(path) =~ /file2$/
    puts "PRUNED #{path}"
    Find.prune 
  end
  puts path
end
# ./
# ./subdir2
# ./subdir2/subsubdir
# ./subdir2/subsubdir/file1

# PRUNED ./subdir2/file2

# ./subdir2/file1

# ./subdir1
# ./subdir1/file1
# PRUNED ./file2
# ./file1
#---
Dir["**/**"].sort.each { |x| puts x }
# file1
# file2
# subdir1
# subdir1/file1
# subdir2
# subdir2/file1
# subdir2/file2
# subdir2/subsubdir
# subdir2/subsubdir/file1
#---
