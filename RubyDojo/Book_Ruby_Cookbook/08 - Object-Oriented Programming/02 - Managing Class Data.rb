class Warning
  @@translations = { :en => 'Wet Floor',
                     :es => 'Piso Mojado' }

  def initialize(language=:en)
    @language = language
  end

  def warn
    @@translations[@language]
  end
end

Warning.new.warn                              # => "Wet Floor"
Warning.new(:es).warn                         # => "Piso Mojado"
#---
class Fate
  NAMES = ['Klotho', 'Atropos', 'Lachesis'].freeze
  @@number_instantiated = 0

  def initialize
    if @@number_instantiated >= NAMES.size
      raise ArgumentError, 'Sorry, there are only three Fates.'
    end 
    @name = NAMES[@@number_instantiated]
    @@number_instantiated += 1 
    puts "I give you... #{@name}!"
  end  
end

Fate.new
# I give you... Klotho!
# => #<Fate:0xb7d2c348 @name="Klotho">

Fate.new
# I give you... Atropos!
# => #<Fate:0xb7d28400 @name="Atropos">

Fate.new
# I give you... Lachesis!
# => #<Fate:0xb7d22168 @name="Lachesis">

Fate.new
# ArgumentError: Sorry, there are only three Fates.
#---
class Module
  def class_attr_reader(*symbols)
    symbols.each do |symbol|
      self.class.send(:define_method, symbol) do
        class_variable_get("@@#{symbol}")
      end
    end
  end
  
  def class_attr_writer(*symbols)
    symbols.each do |symbol|
      self.class.send(:define_method, "#{symbol}=") do |value|
        class_variable_set("@@#{symbol}", value)
      end
    end
  end

  def class_attr_accessor(*symbols)
    class_attr_reader(*symbols)
    class_attr_writer(*symbols)
  end
end
#---
Fate.number_instantiated
# NoMethodError: undefined method `number_instantiated' for Fate:Class

class Fate
  class_attr_reader :number_instantiated
end
Fate.number_instantiated        # => 3
#---
