require 'csv'

pipe_separated="1|2ENDa|bEND"

CSV::Reader.parse(pipe_separated, '|', 'END') { |r| r.each { |c| puts c } }
# 1
# 2
# a
# b

require 'rubygems'
require 'faster_csv'
FasterCSV.parse(pipe_separated, :col_sep=>'|', :row_sep=>'END') do |r|
  r.each { |c| puts c }
end
# 1
# 2
# a
# b
#---
data = [[1,2,3],['A','B','C'],['do','re','mi']]

open('first3.csv', 'w') do |output|
  CSV::Writer.generate(output, ':', '-END-') do |writer|
    data.each { |x| writer << x }
  end
end
open('first3.csv') { |input| input.read() }
# => "1:2:3-END-A:B:C-END-do:re:mi-END-"

FasterCSV.open('first3.csv', 'w', :col_sep=>':', :row_sep=>'-END-') do |output|
  data.each { |x| output << x }
end
open('first3.csv') { |input| input.read() }
# => "1:2:3-END-A:B:C-END-do:re:mi-END-"
#---
class MyFasterCSV < FasterCSV
  def init_parsers(options)
    super
    @parsers[:csv_row] = 
         / \G(?:^|#{Regexp.escape(@col_sep)})     # anchor the match
           (?: '((?>[^']*)(?>''[^']*)*)'          # find quoted fields
               |                                  # ... or ...
               ([^'#{Regexp.escape(@col_sep)}]*)  # unquoted fields
               )/x
  end
end
   #Regexp.new(@parsers[:csv_row].source.gsub('"', "'"))
MyFasterCSV.parse("1,'2,3',4") { |r| puts r }
# 1
# 2,3
# 4
#---
missing_quotes=%{20051002, Alice says, "I saw that!"}
CSV::Reader.parse(missing_quotes) { |r| r.each { |c| puts c } }
# CSV::IllegalFormatError: CSV::IllegalFormatError

unescaped_quotes=%{20051002, "Alice says, "I saw that!""}
FasterCSV.parse(unescaped_quotes) { |r| r.each { |c| puts c } }
# FasterCSV::MalformedCSVError: Unclosed quoted field.
#---
