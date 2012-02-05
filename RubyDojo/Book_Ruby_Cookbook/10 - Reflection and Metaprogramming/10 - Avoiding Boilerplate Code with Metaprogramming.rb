class Fetcher
  def fetch(how_many)
    puts "Fetching #{how_many ? how_many : "all"}."
  end

  def fetch_one
    fetch(1)
  end

  def fetch_ten
   fetch(10)
  end

  def fetch_all
    fetch(nil)
  end
end
#---
class GeneratedFetcher
  def fetch(how_many)
    puts "Fetching #{how_many ? how_many : "all"}."
  end

  [['one', 1], ['ten', 10], ['all', nil]].each do |name, number|
    define_method("fetch_#{name}") do
      fetch(number)
    end
  end
end

GeneratedFetcher.instance_methods - Object.instance_methods
# => ["fetch_one", "fetch", "fetch_ten", "fetch_all"]

GeneratedFetcher.new.fetch_one
# Fetching 1.

GeneratedFetcher.new.fetch_all
# Fetching all.
#---
class Numeric
  [['add', '+'], ['subtract', '-'], ['multiply', '*',],
   ['divide', '/']].each do |method, operator|
    define_method("#{method}_2") do
      method(operator).call(2)
    end
  end
end

4.add_2                                           # => 6
10.divide_2                                       # => 5
#---
define_method 'call_with_args' do |*args, &block|
  block.call(*args)
end

call_with_args(1, 2) { |n1, n2| n1 + n2 }                    # => 3
call_with_args 'mammoth' { |x| x.upcase }                    # => "MAMMOTH"
#---
