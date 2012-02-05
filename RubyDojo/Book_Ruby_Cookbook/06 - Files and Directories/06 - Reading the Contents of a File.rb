#Put some stuff into a file.
open('sample_file', 'w') do |f| 
  f.write("This is line one.\nThis is line two.") 
end

# Then read it back out.
open('sample_file') { |f| f.read }
# => "This is line one.\nThis is line two."
#---
File.read('sample_file')
# => "This is line one.\nThis is line two."
#---
open('sample_file') { |f| f.readlines }
# => ["This is line one.\n", "This is line two."]
#---
open('sample_file').each { |x| p x }
# "This is line one.\n"
# "This is line two."
#---
puts open('conclusion') { |f| f.read(50) }
# "I know who killed Mr. Lambert," said Joe. "It was
#---
# Create a file...
open('end_separated_records', 'w') do |f|
  f << %{This is record one.
It spans multiple lines.ENDThis is record two.END}
end

# And read it back in.
open('end_separated_records') { |f| f.each('END') { |record| p record } }
# "This is record one.\nIt spans multiple lines.END"
# "This is record two.END"

#---
# Create a file...
open('pipe_separated_records', 'w') do |f|
  f << "This is record one.|This is record two.|This is record three."
end

# And read it back in.
open('pipe_separated_records') { |f| f.readlines('|') }
# => ["This is record one.|", "This is record two.|",
#     "This is record three."]
#---
open('newline_separated_records', 'w') do |f|
  f.puts 'This is record one. It cannot span multiple lines.'
  f.puts 'This is record two.'
end

open('newline_separated_records') { |f| f.each { |x| p x } }
# "This is record one. It cannot span multiple lines.\n"
# "This is record two.\n"
#---
open('file_from_unknown_os') { |f| f.read().split(/\r?\n|\r(?!\n)/) }
#---
"This line has a Unix/Mac OS X newline.\n".chomp
# => "This line has a Unix/Mac OS X newline."

"This line has a Windows newline.\r\n".chomp
# => "This line has a Windows newline."

"This line has an old-style Macintosh newline.\r".chomp
# => "This line has an old-style Macintosh newline."

"This string contains two newlines.\n\n".chomp
# "This string contains two newlines.\n"

'This is record two.END'.chomp('END')
# => "This is record two."

'This string contains no newline.'.chomp
# => "This string contains no newline."
#---
open('pipe_separated_records') do |f| 
  f.each('|') { |l| puts l.chomp('|') }
end
# This is record one.
# This is record two.
# This is record three.

lines = open('pipe_separated_records') { |f| f.readlines('|') }
# => ["This is record one.|", "This is record two.|", 
#     "This is record three."]
lines.each { |l| l.chomp!('|') }
# => ["This is record one.", "This is record two.", "This is record three."]
#---
class File
  def each_chunk(chunk_size=1024)
    yield read(chunk_size) until eof?
  end
end

open("pipe_separated_records") do |f|
  f.each_chunk(15) { |chunk| puts chunk }
end
# This is record 
# one.|This is re
# cord two.|This 
# is record three
# .
#---
