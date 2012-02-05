class String
  def word_count
    frequencies = Hash.new(0)
    downcase.scan(/\w+/) { |word| frequencies[word] += 1 }
   return frequencies
  end
end

%{Dogs dogs dog dog dogs.}.word_count
# => {"dogs"=>3, "dog"=>2}
%{"I have no shame," I said.}.word_count
# => {"no"=>1, "shame"=>1, "have"=>1, "said"=>1, "i"=>2}
#---
# Just like /\w+/, but doesn't consider underscore part of a word.
/[0-9A-Za-z]/ 

# Anything that's not whitespace is a word.
/[^\S]+/

# Accept dashes and apostrophes as parts of words.
/[-'\w]+/

# A pretty good heuristic for matching English words.
/(\w+([-'.]\w+)*/
#---
class String
  def word_count
    frequencies = Hash.new(0)
    downcase.scan(/(\w+([-'.]\w+)*)/) { |word, ignore| frequencies[word] += 1 }
    return frequencies
  end
end

%{"That F.B.I. fella--he's quite the man-about-town."}.word_count
# => {"quite"=>1, "f.b.i"=>1, "the"=>1, "fella"=>1, "that"=>1, 
#     "man-about-town"=>1, "he's"=>1}
#---
french = "il \xc3\xa9tait une fois"
french.word_count
# => {"fois"=>1, "une"=>1, "tait"=>1, "il"=>1}
#---
$KCODE='u'
french.word_count
# => {"fois"=>1, "une"=>1, "était"=>1, "il"=>1}
#---
