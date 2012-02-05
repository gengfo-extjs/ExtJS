# scriptlines.rb
# A ScriptLines instance analyses a Ruby script and maintains
# counters for the total number of lines, lines of code, etc.
class ScriptLines

  attr_reader :name
  attr_accessor :bytes, :lines, :lines_of_code, :comment_lines

  LINE_FORMAT = '%8s %8s %8s %8s   %s'

  def self.headline
    sprintf LINE_FORMAT, "BYTES", "LINES", "LOC", "COMMENT", "FILE"
  end

  # The 'name' argument is usually a filename
  def initialize(name)
    @name = name
    @bytes = 0
    @lines = 0    # total number of lines
    @lines_of_code = 0
    @comment_lines = 0
  end

  # Iterates over all the lines in io (io might be a file or a
  # string), analyses them and appropriately increases the counter
  # attributes.
  def read(io)
    in_multiline_comment = false
    io.each { |line|
      @lines += 1
      @bytes += line.size
      case line
      when /^=begin(\s|$)/
        in_multiline_comment = true
        @comment_lines += 1
      when /^=end(\s|$)/:
        @comment_lines += 1
        in_multiline_comment = false
      when /^\s*#/
        @comment_lines += 1
      when /^\s*$/
        # empty/whitespace only line
      else
        if in_multiline_comment
          @comment_lines += 1
        else
          @lines_of_code += 1
        end
      end
    }
  end

  # Get a new ScriptLines instance whose counters hold the
  # sum of self and other.
  def +(other)
    sum = self.dup
    sum.bytes += other.bytes
    sum.lines += other.lines
    sum.lines_of_code += other.lines_of_code
    sum.comment_lines += other.comment_lines
    sum
  end

  # Get a formatted string containing all counter numbers and the
  # name of this instance.
  def to_s
    sprintf LINE_FORMAT,
      @bytes, @lines, @lines_of_code, @comment_lines, @name
  end
end
#---
task 'stats' do
  require 'scriptlines'

  files = FileList['lib/**/*.rb']

  puts ScriptLines.headline
  sum = ScriptLines.new("TOTAL (#{files.size} file(s))")

  # Print stats for each file.
  files.each do |fn|
    File.open(fn) do |file|
      script_lines = ScriptLines.new(fn)
      script_lines.read(file)
      sum += script_lines
      puts script_lines
    end
  end

  # Print total stats.
  puts sum
end
#---
$ rake stats
(in /usr/local/lib/ruby/gems/1.8/gems/highline-1.0.1)
   BYTES  LINES    LOC  COMMENT   FILE
   18626    617    360    196   lib/highline.rb
   12745    375    168    181   lib/highline/menu.rb
   15760    430    181    227   lib/highline/question.rb
   801       25      7     14   lib/highline/import.rb
   47932   1447    716    618   TOTAL (4 scripts)
#---
