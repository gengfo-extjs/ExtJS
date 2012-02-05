class String
  def scramble
    (split //).sort_by { rand }.join
  end
end

"I once was a normal string.".scramble      
# => "i arg cn lnws.Ioateosma n r"
#---
class UnpredictableString < String
  def scramble
    (split //).sort_by { rand }.join
  end

  def inspect
    scramble.inspect
  end
end

str = UnpredictableString.new("It was a dark and stormy night.")
# => " hsar gsIo atr tkd  naaniwdt.ym"
str
# => "ts dtnwIktsr oydnhgi   .mara aa"
#---
class Array
  def sum(start_at=0)
    inject(start_at) { |sum, x| sum + x }
  end
end
#---
[79, 14, 2].sum                     # => 95
['so', 'fa'].sum('')                # => "sofa"
[79, 'so'].sum
# TypeError: String can't be coerced into Fixnum
#---
class NumericArray < Array
  def sum
    inject(0) { |sum, x| sum + x }
  end
end
#---
