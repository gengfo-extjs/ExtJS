octal = "\000\001\010\020"
octal.each_byte { |x| puts x }
# 0
# 1
# 8
# 16

hexadecimal = "\x00\x01\x10\x20"
hexadecimal.each_byte { |x| puts x }
# 0
# 1
# 16
# 32
#---
open('smiley.html', 'wb') do |f|
  f << '<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">'
  f << "\xe2\x98\xBA"
end
#---
"\a" == "\x07"  # => true  #ASCII 0x07 = BEL (Sound system bell)
"\b" == "\x08"  # => true  #ASCII 0x08 = BS (Backspace)
"\e" == "\x1b"  # => true  #ASCII 0x1B = ESC (Escape)
"\f" == "\x0c"  # => true  #ASCII 0x0C = FF (Form feed)
"\n" == "\x0a"  # => true  #ASCII 0x0A = LF (Newline/line feed)
"\r" == "\x0d"  # => true  #ASCII 0x0D = CR (Carriage return)
"\t" == "\x09"  # => true  #ASCII 0x09 = HT (Tab/horizontal tab)
"\v" == "\x0b"  # => true  #ASCII 0x0B = VT (Vertical tab)
#---
"\x10\x11\xfe\xff"                 # => "\020\021\376\377"
"\x48\145\x6c\x6c\157\x0a"         # => "Hello\n"
#---
"\\".size                          # => 1
"\\" == "\x5c"                     # => true
"\\n"[0] == ?\\                    # => true
"\\n"[1] == ?n                     # => true
"\\n" =~ /\n/                      # => nil
#---
"\C-a\C-b\C-c"                    # => "\001\002\003"
"\M-a\M-b\M-c"                    # => "\341\342\343"
#---
?\C-a                                     # => 1
?\M-z                                     # => 250

contains_control_chars = /[\C-a-\C-^]/
'Foobar' =~ contains_control_chars        # => nil
"Foo\C-zbar" =~ contains_control_chars    # => 3

contains_upper_chars = /[\x80-\xff]/
'Foobar' =~ contains_upper_chars          # => nil
"Foo\212bar" =~ contains_upper_chars      # => 3
#---
def snoop_on_keylog(input)
  input.each_byte  do |b|
    case b
      when ?\C-c; puts 'Control-C: stopped a process?'
      when ?\C-z; puts 'Control-Z: suspended a process?'
      when ?\n;   puts 'Newline.'
      when ?\M-x; puts 'Meta-x: using Emacs?'
    end
  end
end

snoop_on_keylog("ls -ltR\003emacsHello\012\370rot13-other-window\012\032")
# Control-C: stopped a process?
# Newline.
# Meta-x: using Emacs?
# Newline.
# Control-Z: suspended a process?
#---
puts "foo\tbar"
# foo     bar
puts %{foo\tbar}
# foo     bar
puts %Q{foo\tbar}
# foo     bar

puts 'foo\tbar'
# foo\tbar
puts %q{foo\tbar}
# foo\tbar
#---
