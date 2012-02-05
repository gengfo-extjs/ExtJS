require 'find'

module Find
  def rename(*paths)
    unrenamable = []
    find(*paths) do |file|
      next unless File.file? file # Skip directories, etc.
      path, name = File.split(file)
      new_name = yield name
      
      if new_name and new_name != name
        new_path = File.join(path, new_name)
        if File.exists? new_path
          unrenamable << file
        else
          puts "Renaming #{file} to #{new_path}" if $DEBUG
          File.rename(file, new_path)
        end
      end
    end
    return unrenamable
  end
  module_function(:rename)
end
#---
require 'fileutils'
tmp_dir = 'tmp_files'
Dir.mkdir(tmp_dir)
['CamelCase.rb', 'OLDFILE.TXT', 'OldFile.txt'].each do |f|
  FileUtils.touch(File.join(tmp_dir, f))
end

tmp_dir = File.join(tmp_dir, 'subdir')
Dir.mkdir(tmp_dir)
['i_am_SHOUTING', 'I_AM_SHOUTING'].each do |f| 
  FileUtils.touch(File.join(tmp_dir, f))
end
#---
$DEBUG = true
Find.rename('./') { |file| file.downcase }
# Renaming ./tmp_files/subdir/I_AM_SHOUTING to ./tmp_files/subdir/i_am_shouting
# Renaming ./tmp_files/OldFile.txt to ./tmp_files/oldfile.txt
# Renaming ./tmp_files/CamelCase.rb to ./tmp_files/camelcase.rb
# => ["./OldFile.txt", "./dir/i_am_SHOUTING"]
#---
Find.rename('./') { |file| file + '.txt' unless file.index('.') }
# Renaming ./tmp_files/subdir/i_am_shouting to ./tmp_files/subdir/i_am_shouting.txt
# Renaming ./tmp_files/subdir/i_am_SHOUTING to ./tmp_files/subdir/i_am_SHOUTING.txt
# => []
#---
module Find
  def change_extensions(extension_mappings, *paths)
    rename(*paths) do |file|
      base, extension = file.split(/(.*)\./)[1..2]
      new_extension = extension
      extension_mappings.each do |re, ext|
        if re.match(extension)
          new_extension = ext
          break
        end
      end
      "#{base}.#{new_extension}"
    end
  end
  module_function(:change_extensions)
end
#---
tmp_dir = 'tmp_graphics'
Dir.mkdir(tmp_dir)
['my.house.jpeg', 'Construction.Gif', 'DSC1001.JPG', '52.PNG'].each do |f|
  FileUtils.touch(File.join(tmp_dir, f))
end
#---
Find.change_extensions({/jpe?g/i => 'jpg',
                        /png/i => 'png',
                        /gif/i => 'gif'}, tmp_dir)
# Renaming tmp_graphics/52.PNG to tmp_graphics/52.png
# Renaming tmp_graphics/DSC1001.JPG to tmp_graphics/DSC1001.jpg
# Renaming tmp_graphics/Construction.Gif to tmp_graphics/Construction.gif
# Renaming tmp_graphics/my.house.jpeg to tmp_graphics/my.house.jpg
#---
