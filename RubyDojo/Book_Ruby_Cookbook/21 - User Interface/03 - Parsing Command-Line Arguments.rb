#!/usr/bin/ruby -w
# cat.rb

ARGV.each { |filename| IO.readlines(filename).each { |line| puts line } }
#---
#!/usr/bin/ruby -w
# cat_argf.rb

ARGF.each { |line| puts line }
#---
#!/usr/bin/ruby
# cat2.rb
require 'optparse'

class CatArguments < Hash
  def initialize(args)
    super()
    self[:show_ends] = ''

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #$0 [options]"
      opts.on('-E', '--show-ends [STRING]', 
              'display [STRING] at end of each line') do |string|
        self[:show_ends] = string || '$'
      end

      opts.on('-n', '--number', 'number all output lines') do
        self[:number_lines] = true
      end
      
      opts.on_tail('-h', '--help', 'display this help and exit') do
        puts opts
        exit
      end
    end

    opts.parse!(args)   
  end  
end

arguments = CatArguments.new(ARGV)
#---
counter = 0
eol = 
ARGF.each do |line|  
  line.sub!(/$/, arguments[:show_ends])
  print '%6.d  ' % (counter += 1) if arguments[:number_lines]
  print line
end
#---
$ ./cat2.rb --help
Usage: ./cat2.rb [options]
    -E, --show-ends [STRING]         display STRING at end of each line
    -n, --number                     number all output lines
    -h, --help                       display this help and exit

$ ./cat2.rb file1 file2
This is file one.
Another line in file one.
This is file two.
I'm a lot more interesting than file one, I'll tell you that!

$ ./cat2.rb file1 -E$ -n file2
     1  This is file one.$
     2  Another line in file one.$
     3  This is file two.$
     4  I'm a lot more interesting than file one, I'll tell you that!$

$ ./cat2.rb --nosuchargument
/usr/lib/ruby/1.8/optparse.rb:1445:in `complete': invalid option: --nosuchargument (OptionParser::InvalidOption)

$ ./cat2.rb --show-ends=" STOP" -- --argument-looking-file
The name of this file STOP
looks just like an argument STOP
for some odd reason. STOP
#---
