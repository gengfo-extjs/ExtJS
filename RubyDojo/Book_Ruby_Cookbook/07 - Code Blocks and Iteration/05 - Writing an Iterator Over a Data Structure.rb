class Tree
  attr_reader :value
  def initialize(value)
    @value = value
    @children = []      
  end

  def <<(value)
    subtree = Tree.new(value)
    @children << subtree
    return subtree
  end
end
#---
t = Tree.new("Parent")
child1 = t << "Child 1"
child1 << "Grandchild 1.1"
child1 << "Grandchild 1.2"
child2 = t << "Child 2"
child2 << "Grandchild 2.1"
#---
class Tree
  def each
    yield value
    @children.each do |child_node| 
      child_node.each { |e| yield e }
    end
  end
end
#---
t.each { |x| puts x }
# Parent
# Child 1
# Grandchild 1.1
# Grandchild 1.2
# Child 2
# Grandchild 2.1
#---
class Array
 def each_from_both_sides()
    front_index = 0
    back_index = self.length-1
    while front_index <= back_index
      yield self[front_index]
      front_index += 1
      if front_index <= back_index
	yield self[back_index]
        back_index -= 1
      end
    end
  end  
end

%w{Curses! been again! foiled I've}.each_from_both_sides { |x| puts x }

# Curses!
# I've
# been
# foiled
# again!
#---
module Enumerable
  def each_n_times(n)
    each { |e| n.times { yield e } }
  end
end

%w{Hello Echo}.each_n_times(3) { |x| puts x }
# Hello
# Hello
# Hello
# Echo
# Echo
# Echo
#---
module Enumerable
  def each_randomly	
    (sort_by { rand }).each { |e| yield e }
  end
end
%w{Eat at Joe's}.each_randomly { |x| puts x }
# Eat 
# Joe's
# at
#---
