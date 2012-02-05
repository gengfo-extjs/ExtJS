require 'csv'
primary_colors = "red,green,blue\nred,yellow,blue"

CSV::Reader.parse(primary_colors) { |row| row.each { |cell| puts cell }} 
# red
# green
# blue
# red
# yellow
# blue

require 'rubygems'
require 'faster_csv'
shakespeare = %{Sweet are the uses of adversity,As You Like It
"We few, we happy few",Henry V
"Seems, madam! nay it is; I know not ""seems.""",Hamlet}

FasterCSV.parse(shakespeare) { |row| puts "'#{row[0]}' -- #{row[1]}"}
# 'Sweet are the uses of adversity' -- As You Like It
# 'We few, we happy few' -- Henry V
# 'Seems, madam! nay it is; I know not "seems."' -- Hamlet
#---
%{"Seems, madam! nay it is; I know not ""seems.""",Hamlet}
#---
def parse_delimited_naive(input, fieldsep=',', rowsep="\n")
  input.split(rowsep).inject([]) do |arr, line| 
    arr << line.split(fieldsep)
  end
end

def join_delimited_naive(structure, fieldsep=',', rowsep="\n")
  rows = structure.inject([]) do |arr, parsed_line|
    arr << parsed_line.join(fieldsep)
  end
  rows.join(rowsep)
end

parse_delimited_naive("1,2,3,4\n5,6,7,8")
# => [["1", "2", "3", "4"], ["5", "6", "7", "8"]]

join_delimited_naive(parse_delimited_naive("1,2,3,4\n5,6,7,8"))
# => "1,2,3,4\n5,6,7,8"

parse_delimited_naive('1;2;3;4|5;6;7;8', ';', '|')
# => [["1", "2", "3", "4"], ["5", "6", "7", "8"]]

parse_delimited_naive('1,"2,3",4')
# => [["1", "\"2", "3\"", "4"]]
#---
data = [[1,2,3],['A','B','C'],['do','re','mi']]

writer = FasterCSV.open('first3.csv', 'w')
data.each { |x| writer << x }
writer.close
puts open('first3.csv').read()
# 1,2,3
# A,B,C
# do,re,mi

data = []
FasterCSV.foreach('first3.csv') { |row|  data << row }
data
# => [["1", "2", "3"], ["A", "B", "C"], ["do", "re", "mi"]]
#---
