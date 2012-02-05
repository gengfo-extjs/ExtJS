require 'rubygems'
require 'spreadsheet/excel'

SUM_SPREADSHEET = 'sum.xls'
workbook = Spreadsheet::Excel.new(SUM_SPREADSHEET)
worksheet = workbook.add_worksheet('Random numbers and their sum.')
sum = 0
random_numbers = (0..9).collect { rand(100) }
worksheet.write_column(0, 0, random_numbers)

format = workbook.add_format(:bold => true)
worksheet.write(10, 0, "Sum:", format)
worksheet.write(10, 1, random_numbers.inject(0) { |sum, x| sum + x })
workbook.close
#---
require 'parseexcel/parser'
workbook = Spreadsheet::ParseExcel::Parser.new.parse(SUM_SPREADSHEET)

worksheet = workbook.worksheet(0)
sum = (0..9).inject(0) do |sum, row| 
  sum + worksheet.cell(row, 0).value.to_i
end

worksheet.cell(10, 0).value                              # => "Sum:"
worksheet.cell(10, 1).value                              # => 602.0
sum                                                      # => 602

#---
class ExcelWithBackground < Spreadsheet::Excel
  def initialize(*args)
    super(*args)
    @format = Format.new(:bg_color => 'white', :fg_color => 'black')
  end
end

workbook = ExcelWithBackground.new(SUM_SPREADSHEET)
# ...
#---
