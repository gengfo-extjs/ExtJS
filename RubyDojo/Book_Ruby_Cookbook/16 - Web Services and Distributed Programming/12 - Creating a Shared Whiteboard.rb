#!/usr/bin/ruby -w
# english_client.rb
require 'drb'
require 'rinda/tuplespace'

# Connect to the TupleSpace...
DRb.start_service
tuplespace = Rinda::TupleSpaceProxy.new(
  DRbObject.new_with_uri('druby://127.0.0.1:61676')
)
#---
counter = 0
DATA.each_line do |line|
  tuplespace.write([(counter += 1), 'English', line.strip.split])
end

__END__
Ruby programmers have more fun
Ruby gurus are obsessed with ducks
Ruby programmers are happy programmers
#---
require 'drb'
require 'rinda/tuplespace'
require 'set'

DRb.start_service
tuplespace = Rinda::TupleSpaceProxy.new(
  DRbObject.new_with_uri('druby://127.0.0.1:61676')
)

# Track of the IDs of the sentences we've translated
translated = Set.new

# Continually read English sentences off of the board.
while english = tuplespace.read([Numeric, 'English', Array])
  # Skip anything we've already translated.
  next if translated.member? english.first
  translated << english.first

  # Translate English to Pig Latin.
  pig_latin = english.last.map do |word|
   if word =~ /^[aeiou]/i
      "#{word}way"
    elsif word =~ /^([^aeiouy]+)(.+)$/i
      "#{$2}#{$1.downcase}ay"
    end
  end

  # Write the Pig Latin translation back onto the board
  tuplespace.write([english.first, 'Pig Latin', pig_latin])
end
#---
#!/usr/bin/ruby -w
# dictionary_building_server.rb
require 'drb'
require 'yaml'
require 'rinda/tuplespace'

# Create a TupleSpace and serve it to the world.
tuplespace = Rinda::TupleSpace.new
DRb.start_service('druby://127.0.0.1:61676', tuplespace)

# Create a dictionary to hold the terms we have seen.
dictionary = Hash.new
# Remove non-English sentences from the board.
while translation = tuplespace.take([Numeric, /^(?!English)/, Array])
  # Match each with its English equivalent.
  english = tuplespace.take([translation.first, 'English', Array])
  # Match up the words, and save the dictionary.
  english.last.zip(translation.last) { |en, tr| dictionary[en] = tr }
  File.open('dictionary.yaml', 'w') { |file| YAML.dump(dictionary, file) }
end
#---
$ ruby dictionary_building_server.rb &
$ ruby english_client.rb
$ ruby pig_latin_client.rb &

$ cat dictionary.yaml
---
happy: appyhay
programmers: ogrammerspray
Ruby: ubyray
gurus: urusgay
ducks: ucksday
obsessed: obsessedway
have: avehay
are: areway
fun: unfay
with: ithway
more: oremay
#---
