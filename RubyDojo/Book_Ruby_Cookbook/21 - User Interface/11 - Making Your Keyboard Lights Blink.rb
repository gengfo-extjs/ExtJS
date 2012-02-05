require 'rubygems'
require 'blinkenlights'

# Turn individual lights on or off.
BlinkenLights.open do |lights|
  lights.left = true
  lights.middle = true
  lights.right = true

  lights.scr = false
  lights.cap = false
  lights.num = false
end

# Display a light show.
BlinkenLights.open do |lights| 
  lights.left_to_right
  10.times { lights.random }
  lights.right_to_left
end
#---
# Display the binary number 6 (that is, 110):
BlinkenLights.new.set(6)
#---
#!/usr/bin/ruby -w
# blink_morse.rb
require 'rubygems'
require 'blinkenlights'

class String

  # Morse code representations for 0-9 and A-Z.
  MORSE_TABLE = %w{01111 00111 00011 00001 00000 10000 11000 11100 11110 11111
                   01 1000 1010 100 0 0010 110 0000 00 0111 101 0100 11 
                   10 111 0110 1101 010 000 1 001 0001 011 1001 1011 1100}

  def to_morse(dit_time = 0.3)
    a = "A"[0]
    zero = "0"[0]
    words = upcase.gsub(/[^A-Z0-9\s]/, "").split
    BlinkenLights.open do |lights|
      words.each do |word|
        word.each_byte do |letter| 
          code = MORSE_TABLE[letter - (letter < a ? zero : a-10)]
          code.each_byte do |signal|
            lights.flash(dit_time * (signal == zero ? 1 : 3))
            sleep(dit_time)         # Space between parts of a letter.
          end
          sleep(dit_time * 3)       # Space between letters.
        end
        sleep(dit_time * 5)         # Space between words.
      end
    end
  end
end

ARGV.shift.to_s.to_morse if $0 == __FILE__
#---
