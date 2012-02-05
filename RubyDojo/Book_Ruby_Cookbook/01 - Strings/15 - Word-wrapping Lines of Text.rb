def wrap(s, width=78)
  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end

wrap("This text is too short to be wrapped.")
# => "This text is too short to be wrapped.\n"

puts wrap("This text is not too short to be wrapped.", 20)
# This text is not too
# short to be wrapped.

puts wrap("These ten-character columns are stifling my creativity!", 10)
# These
# ten-character
# columns
# are
# stifling
# my
# creativity!
#---
poetry = %q{It is an ancient Mariner,
And he stoppeth one of three.
"By thy long beard and glittering eye,
Now wherefore stopp'st thou me?}

puts wrap(poetry, 20)
# It is an ancient
# Mariner,
# And he stoppeth one
# of three.
# "By thy long beard
# and glittering eye,
# Now wherefore
# stopp'st thou me?
#---
prose = %q{I find myself alone these days, more often than not,
watching the rain run down nearby windows. How long has it been
raining? The newspapers now print the total, but no one reads them
anymore.}

puts wrap(prose, 60)
# I find myself alone these days, more often than not,
# watching the rain run down nearby windows. How long has it
# been
# raining? The newspapers now print the total, but no one
# reads them
# anymore.
#---
def reformat_wrapped(s, width=78)
 s.gsub(/\s+/, " ").gsub(/(.{1,#{width}})( |\Z)/, "\\1\n")
end
#---
def reformat_wrapped(s, width=78)
  lines = []
  line = ""
  s.split(/\s+/).each do |word|
    if line.size + word.size >= width    
      lines << line
      line = word
    elsif line.empty?
      line = word
    else
      line << " " << word
    end
  end
  lines << line if line
  return lines.join "\n"
end

puts reformat_wrapped(prose, 60)
# I find myself alone these days, more often than not,
# watching the rain run down nearby windows. How long has it
# been raining? The newspapers now print the total, but no one
# reads them anymore.
#---
