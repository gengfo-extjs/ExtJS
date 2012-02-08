require "test/unit"
require File.expand_path(File.dirname(__FILE__) + "/../lib/roman_numerial_by_map")

class RomanNumerialByNapTest < Test::Unit::TestCase
  
  def test_get_roman_from_integer()
    romanNumerialByMap = RomanNumerialByNap.new
    
    from = 1000;    
    
    assert_equal("M", romanNumerialByMap.getRomanByInteger(from));
    
  end
  
  def test_roman_map_thousand()
    
    romanNumerialByMap = RomanNumerialByNap.new
    
    
  end
    
 #TODO
 def test_get_integer_from_roman()
   
 end
     
  
end
