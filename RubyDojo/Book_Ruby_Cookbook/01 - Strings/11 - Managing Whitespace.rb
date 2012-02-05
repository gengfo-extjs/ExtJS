" \tWhitespace at beginning and end. \t\n\n".strip
# => "Whitespace at beginning and end."
#---
s = "Some text."
s.center(15)                    # => "  Some text.   "
s.ljust(15)                     # => "Some text.     "
s.rjust(15)                     # => "     Some text."
#---
#Normalize Ruby source code by replacing tabs with spaces
ruby_ode.gsub("\t", "  ")

#Transform Windows-style newlines to Unix-style newlines
"Line one\n\rLine two\n\r".gsub("\n\r", "\n")
# => "Line one\nLine two\n"

#Transform all runs of whitespace into a single space character
"\n\rThis string\t\t\tuses\n all\tsorts\nof whitespace.".gsub(/\s+/, " ")
# => " This string uses all sorts of whitespace."
#---
" \bIt's whitespace, Jim,\vbut not as we know it.\n".gsub(/[\s\b\v]+/, " ")
# => " It's whitespace, Jim, but not as we know it. "
#---
s = "   Whitespace madness! "
s.lstrip                              # => "Whitespace madness! "
s.rstrip                              # => "   Whitespace madness!"
#---
"four".center(5)                      # => "four "
"four".center(6)                      # => " four "
#---
