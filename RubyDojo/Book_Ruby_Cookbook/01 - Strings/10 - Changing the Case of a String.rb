s = 'HELLO, I am not here. I WENT to tHe MaRKEt.'
s.upcase           # => "HELLO, I AM NOT HERE. I WENT TO THE MARKET."
s.downcase         # => "hello, i am not here. i went to the market."
s.swapcase         # => "hello, i AM NOT HERE. i went TO ThE mArkeT."
s.capitalize       # => "Hello, i am not here. i went to the market."
#---
un_banged = 'Hello world.'
un_banged.upcase	# => "HELLO WORLD."
un_banged 		# => "Hello world."

banged = 'Hello world.'
banged.upcase!		# => "HELLO WORLD."
banged 			# => "HELLO WORLD."
#---
class String
  def capitalize_first_letter
    self[0].chr.capitalize + self[1, size]
  end

  def capitalize_first_letter!
    unless self[0] == (c = self[0,1].upcase[0])
      self[0] = c
      self
    end
    # Return nil if no change was made, like upcase! et al.
  end	
end

s = 'i told Alice. She remembers now.'
s.capitalize_first_letter	# => "I told Alice. She remembers now."
s	                        # => "i told Alice. She remembers now."
s.capitalize_first_letter!
s                               # => "I told Alice. She remembers now."
#---
'LOWERCASE ALL VOWELS'.tr('AEIOU', 'aeiou')
# => "LoWeRCaSe aLL VoWeLS"

'Swap case of ALL VOWELS'.tr('AEIOUaeiou', 'aeiouAEIOU')
# => "SwAp cAsE Of aLL VoWeLS"
#---
