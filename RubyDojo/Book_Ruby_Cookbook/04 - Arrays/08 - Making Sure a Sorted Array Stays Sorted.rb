class SortedArray < Array

  def initialize(*args, &sort_by)
    @sort_by = sort_by || Proc.new { |x,y| x <=> y }	
    super(*args)
    sort! &sort_by
  end

  def insert(i, v)
    # The next line could be further optimized to perform a
    # binary search.
    insert_before = index(find { |x| @sort_by.call(x, v) == 1 })
    super(insert_before ? insert_before : -1, v)
  end

  def <<(v)
    insert(0, v)
  end

  alias push <<
  alias unshift <<
#---
  ["collect!", "flatten!", "[]="].each do |method_name|
    module_eval %{
      def #{method_name}(*args)
        super
        sort! &@sort_by
      end
    }
  end

  def reverse!
    #Do nothing; reversing the array would disorder it.
  end
end
#---
a = SortedArray.new([3,2,1])                   # => [1, 2, 3]
#---
unsorted= ["b", "aa", "a", "cccc", "1", "zzzzz", "k", "z"]
strings_by_alpha = SortedArray.new(unsorted)
# => ["1", "a", "aa", "b", "cccc", "k", "z", "zzzzz"]
strings_by_length = SortedArray.new(unsorted) do |x,y| 
  x.length <=> y.length
end
# => ["b", "z", "a", "k", "1", "aa", "cccc", "zzzzz"]
#---
a << -1                              # => [-1, 1, 2, 3]
a << 1.5                             # => [-1, 1, 1.5, 2, 3]
a.push(2.5)                          # => [-1, 1, 1.5, 2, 2.5, 3]
a.unshift(1.6)                       # => [-1, 1, 1.5, 1.6, 2, 2.5, 3]
#---
a = SortedArray.new([10, 6, 4, -4, 200, 100])  
# => [-4, 4, 6, 10, 100, 200]
a.collect! { |x| x * -1 }          # => [-200, -100, -10, -6, -4, 4]

a[3] = 25
a                                  # => [-200, -100, -10, -4, 4, 25]
# That is, -6 has been replaced by 25 and the array has been re-sorted.

a[1..2] = [6000, 10, 600, 6]
a                                  # => [-200, -4, 4, 6, 10, 25, 600, 6000]
# That is, -100 and -10 have been replaced by 6000, 10, 600, and 6,
# and the array has been re-sorted.
#---
class SortedArray
  def []=(*args)    
    if args.size == 3     
      #e.g. "a[6,3] = [1,2,3]"
      start, length, value = args
      slice! Range.new(start, start+length, true)
      (value.respond_to? :each) ? value.each { |x| self << x } : self << value
    elsif args.size == 2
      index, value = args  
      if index.is_a? Numeric
        #e.g. "a[0] = 10" (the most common form of array assignment)
        delete_at(index)
        self << value
      elsif index.is_a? Range
        #e.g. "a[0..3] = [1,2,3]"
        slice! index
        (value.respond_to? :each) ? value.each { |x| self << x } : self << value
      else
        #Not supported. Delegate to superclass; will probably give an error.
        super
        sort!(&sort_by)
      end
    else
      #Not supported. Delegate to superclass; will probably give an error.
      super
      sort!(&sort_by)
    end
  end
end
#---
a = SortedArray.new([1,2,3,4,5,6])
a[0] = 10
a                                        # => [2, 3, 4, 5, 6, 10]

a[0, 2] = [100, 200]
a                                        # => [4, 5, 6, 10, 100, 200]

a[1..2] = [-4, 6]
a                                        # => [-4, 4, 6, 10, 100, 200]
#---
stripes = SortedArray.new(["aardwolf", "zebrafish"])
stripes[1].upcase!
stripes                                 # => ["aardwolf", "ZEBRAFISH"]
stripes.sort!                           # => ["ZEBRAFISH", "aardwolf"]
#---
class Object
  def to_frozen
    f = self
    unless frozen?       
      begin
        f = dup.freeze
      rescue TypeError 
        #This object can't be duped (e.g. Fixnum); fortunately,
        #it usually can't be modified either
      end
    end
    return f
  end
end
#---
class FrozenCopySortedArray < SortedArray
  def insert(i, v)    
    insert_before = index(find { |x| x > v })
    super(insert_before ? insert_before : -1, v.to_frozen)
  end

  ["initialize", "collect!", "flatten!"].each do |method_name|
    define_method(method_name) do
      super
      each_with_index { |x, i| self[i] = x.to_frozen }
      # No need to sort; by doing an assignment to every element
      # in the array, we've made #insert keep the array sorted.
    end
  end
end

stripes = SortedArray.new(["aardwolf", "zebrafish"])
stripes[1].upcase!
# TypeError: can't modify frozen string
#---
[1, "string"].sort 
# ArgumentError: comparison of Fixnum with String failed

a = SortedArray.new([1])
a << "string"
# ArgumentError: comparison of Fixnum with String failed
#---
a = SortedArray.new([3, 2, 1])             # => [1, 2, 3]
a += [1, -10]                              # => [1, 2, 3, 1, -10]
a.class                                    # => Array
#---
class SortedArray
  def + (other_array)
    SortedArray.new(super)
  end
end
#---
