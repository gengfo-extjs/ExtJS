class File
  def File.same_contents(p1, p2)
    return false if File.exists?(p1) != File.exists?(p2)
    return true if !File.exists?(p1)
    return true if File.expand_path(p1) == File.expand_path(p2)     
    return false if File.ftype(p1) != File.ftype(p2) ||
      File.size(p1) != File.size(p2)
#---
    open(p1) do |f1|
      open(p2) do |f2|
        blocksize = f1.lstat.blksize
        same = true
        while same && !f1.eof? && !f2.eof?
          same = f1.read(blocksize) == f2.read(blocksize)
        end    
        return same
      end
    end
  end
end
#---
1.upto(2) do |i|
  open("output#{i}", 'w') { |f| f << 'x' * 10000 }
end
File.same_contents('output1', 'output2')                # => true

open("output1", 'a') { |f| f << 'x' }
open("output2", 'a') { |f| f << 'y' }
File.same_contents('output1', 'output2')                # => false

File.same_contents('nosuchfile', 'output1')             # => false
File.same_contents('nosuchfile1', 'nosuchfile2')        # => true
#---
require 'rubygems'
require 'diff/lcs/hunk'

def diff_as_string(data_old, data_new, format=:unified, context_lines=3)
#---
  data_old = data_old.split(/\n/).map! { |e| e.chomp }
  data_new = data_new.split(/\n/).map! { |e| e.chomp }
#---
  output = ""
  diffs = Diff::LCS.diff(data_old, data_new)
  return output if diffs.empty?
  oldhunk = hunk = nil  
  file_length_difference = 0
  diffs.each do |piece|
    begin
      hunk = Diff::LCS::Hunk.new(data_old, data_new, piece, context_lines,
                                 file_length_difference)
      file_length_difference = hunk.file_length_difference      
      next unless oldhunk      

      # Hunks may overlap, which is why we need to be careful when our
      # diff includes lines of context. Otherwise, we might print
      # redundant lines.
      if (context_lines > 0) and hunk.overlaps?(oldhunk)
        hunk.unshift(oldhunk)
      else
        output << oldhunk.diff(format)
      end
    ensure
      oldhunk = hunk
      output << "\n"
    end
  end  

  #Handle the last remaining hunk
  output << oldhunk.diff(format) << "\n"
end
#---
s1 = "This is line one.\nThis is line two.\nThis is line three.\n"
s2 = "This is line 1.\nThis is line two.\nThis is line three.\n" +
	"This is line 4.\n"
puts diff_as_string(s1, s2)
# @@ -1,4 +1,5 @@
# -This is line one.
# +This is line 1.
#  This is line two.
#  This is line three.
# +This is line 4.
#---
open('old_file', 'w') { |f| f << s1 }
open('new_file', 'w') { |f| f << s2 }

puts %x{diff old_file new_file}
# 1c1
# < This is line one.
# ---
# > This is line 1.
# 3a4
# > This is line 4.
#---
