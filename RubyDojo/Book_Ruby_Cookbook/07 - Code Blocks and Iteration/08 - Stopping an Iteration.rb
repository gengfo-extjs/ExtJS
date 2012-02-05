1.upto(10) do |x| 
  puts x
  break if x == 3
end
# 1
# 2 
# 3
#---
block = Proc.new do |x|
  puts x
  break if x == 3
  puts x + 2
end

block.call(5)
# 5
# 7

block.call(3)
# 3
# LocalJumpError: break from proc-closure
#---
def find(*paths)
  paths.each do |p|
    catch(:prune) do     
      #Process p as a file or directory...
    end
    # When you call Fine.prune you'll end up here.
  end
end

def prune
  throw :prune
end
#---
