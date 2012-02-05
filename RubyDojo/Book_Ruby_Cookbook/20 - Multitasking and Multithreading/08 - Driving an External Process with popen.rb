%x{whoami}                                      # => "leonardr\n"
puts %x{ls -a empty_dir}
# .
# ..
#---
IO.popen('tail -3', 'r+') do |pipe|
  1.upto(100) { |i| pipe << "This is line #{i}.\n" }
  pipe.close_write
  puts pipe.read
end
# This is line 98.
# This is line 99.
# This is line 100.
#---
IO.popen('-', 'r+') do |child_filehandle|
  if child_filehandle
    $stderr.puts "I am the parent: #{child_filehandle.inspect}"
    child_filehandle.puts '404'
    child_filehandle.close_write
    puts "My child says the square root of 404 is #{child_filehandle.read}"
  else
    $stderr.puts "I am the child: #{child_filehandle.inspect}"
    number = $stdin.readline.strip.to_i
    $stdout.puts Math.sqrt(number)
  end
end
# I am the child: nil
# I am the parent: #<IO:0xb7d25b9c>
# My child says the square root of 404 is 20.0997512422418
#---
