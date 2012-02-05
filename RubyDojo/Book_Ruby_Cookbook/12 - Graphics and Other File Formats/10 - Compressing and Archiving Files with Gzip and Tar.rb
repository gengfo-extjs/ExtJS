require 'zlib'

file = 'compressed.gz'
Zlib::GzipWriter.open(file) do |gzip|
  gzip << "For my next trick, I'll be written to a compressed file."
  gzip.close
end

open(file, 'rb') { |f| f.read(10) }
# => "\037\213\010\000\201\2766D\000\003"

Zlib::GzipReader.open(file) { |gzip| gzip.read }
# => "For my next trick, I'll be written to a compressed file."
#---
open('compressed.gz', 'wb') do |file|
  gzip = Zlib::GzipWriter.new(file)
  gzip << "For my next trick, I'll be written to a compressed file."
  gzip.close
end
#---
deflated = Zlib::Deflate.deflate("I'm a compressed string.")
# => "x\234\363T\317UHTH..."
Zlib::Inflate.inflate(deflated)
# => "I'm a compressed string."
#---
require 'rubygems'
require 'archive/tar/minitar'

open('tarball.tar', 'wb') do |f|
  Archive::Tar::Minitar::Writer.open(f) do |w|   
    w.add_file('file1', :mode => 0644, :mtime => Time.now) do |stream, io|
      stream.write('This is file 1.')
    end

    w.mkdir('subdirectory', :mode => 0755, :mtime => Time.now)   
    w.add_file('subdirectory/file2', :mode => 0600, 
               :mtime => Time.now) do |stream, io|
      stream.write('This is file 2.')
    end
  end
end
#---
def browse_tarball(filename)
  open(filename, 'rb') do |f|
    Archive::Tar::Minitar::Reader.open(f).each do |entry|
      puts %{I see a file "#{entry.name}" that's #{entry.size} bytes long.}
    end
  end
end

browse_tarball('tarball.tar')
# I see a file "file1" that's 15 bytes long.
# I see a file "subdirectory" that's 0 bytes long.
# I see a file "subdirectory/file2" that's 15 bytes long.
#---
def make_tarball(destination, *paths)
  Zlib::GzipWriter.open(destination) do |gzip|
    out = Archive::Tar::Minitar::Output.new(gzip)
    paths.each do |file|
      puts "Packing #{file}"
      Archive::Tar::Minitar.pack_file(file, out)
    end
    out.close
  end
end
#---
Dir.mkdir('colors')
paths = ['colors/burgundy', 'colors/beige', 'colors/clear']
paths.each do |path| 
  open(path, 'w') do |f| 
    f.puts %{This is a dummy file.}
  end
end

make_tarball('new_tarball.tgz', *paths)
# Packing colors/burgundy
# Packing colors/beige
# Packing colors/clear
=> #<File:new_tarball.tgz (closed)>
#---
