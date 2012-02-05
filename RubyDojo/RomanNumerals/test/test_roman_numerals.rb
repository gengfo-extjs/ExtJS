DIGITS = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }
  
  # The largest integer representable as a Roman numerable by this module
  MAX = 3999
  
  # Maps some integers to their Roman numeral values
  @@digits_lookup = DIGITS.inject({
    4 => 'IV',
    9 => 'IX',
    40 => 'XL',
    90 => 'XC',
    400 => 'CD',
    900 => 'CM'}) do |memo, pair|
    memo.update({pair.last => pair.first})
  end
  

# puts @@digits_lookup.keys.sort.reverse

puts "MCD".to_s.upcase.split(//).reverse