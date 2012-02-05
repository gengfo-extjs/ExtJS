module StringTheory
  class String
    def initialize(length=10**-33)
      @length = length
    end
  end
end

String.new                                       # => ""

StringTheory::String.new
# => #<StringTheory::String:0xb7c343b8 @length=1.0e-33>
#---
module StringTheory2
 RubyString = String
 class String
   def initialize(length=10**-33)
     @length = length
   end
  end

  RubyString.new("This is a built-in string, not a StringTheory2::String")
end
# => "This is a built-in string, not a StringTheory2::String"
#---
