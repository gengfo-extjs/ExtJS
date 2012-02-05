require 'rubygems'
require 'classifier'

classifier = Classifier::Bayes.new('Spam', 'Not spam')

classifier.train_spam 'are you in the market for viagra? we sell viagra'
classifier.train_not_spam 'hi there, are we still on for lunch?'
#---
classifier.classify "we sell the cheapest viagra on the market"
# => "Spam"
classifier.classify "lunch sounds great"
# => "Not spam"
#---
classifier
# => #<Classifier::Bayes:0xb7cec7c8 
#      @categories={:"Not spam"=>
#                     { :lunch=>1, :for=>1, :there=>1, 
#                       :"?"=>1, :still=>1, :","=>1 }, 
#                   :Spam=>
#                     { :market=>1, :for=>1, :viagra=>2, :"?"=>1, :sell=>1 }
#                  }, 
#      @total_words=12>
#---
classifier = Classifier::Bayes.new('Interesting', 'Funny', 'Dramatic')

classifier.train 'Interesting', "Leaving reminds us of what we can part
  with and what we can't, then offers us something new to look forward
  to, to dream about."
classifier.train 'Funny', "Knock knock. Who's there? Boo boo. Boo boo
  who? Don't cry, it is only a joke."
classifier.train 'Dramatic', 'I love you! I hate you! Get out right
  now.'

classifier.classify 'what!'
# => "Dramatic"
classifier.classify "who's on first?"
# => "Funny"
classifier.classify 'perchance to dream'
# => "Interesting"
#---
classifier.untrain_funny "boo"
classifier.untrain "Dramatic", "out"
#---
