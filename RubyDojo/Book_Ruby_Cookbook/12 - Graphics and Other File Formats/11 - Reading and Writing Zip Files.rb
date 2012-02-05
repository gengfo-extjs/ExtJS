require 'rubygems'
require 'zip/zipfilesystem'

Zip::ZipFile.open('zipfile.zip', Zip::ZipFile::CREATE) do |zip|
  zip.file.open('file1', 'w') { |f1| f1 << 'This is file 1.' }
  zip.dir.mkdir('subdirectory')
  zip.file.open('subdirectory/file2', 'w') { |f1| f1 << 'This is file 2.' }
end
#---
def process_zipfile(zip, path='')
  if zip.file.file? path
    puts %{#{path}: "#{zip.read(path)}"}
  else
    unless path.empty?
      path += '/'
      puts path
    end
    zip.dir.foreach(path) do |filename|
      process_zipfile(zip, path + filename)
    end
  end
end
#---
Zip::ZipFile.open('zipfile.zip') do |zip|
  process_zipfile(zip)
end
# subdirectory/
# subdirectory/file2: "This is file 2."
# file1: "This is file 1."
#---
Zip::ZipFile.open('zipfile2.zip', Zip::ZipFile::CREATE) do |zip|
  zip.get_output_stream('file1') { |f| f << 'This is file 1.' }
  zip.mkdir('subdirectory')
  zip.get_output_stream('subdirectory/file2') { |f| f << 'This is file 2.' }
end
#---
