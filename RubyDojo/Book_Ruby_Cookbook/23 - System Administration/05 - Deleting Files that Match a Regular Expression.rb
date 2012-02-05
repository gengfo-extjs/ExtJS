def delete_matching_regexp(dir, regex)
  Dir.entries(dir).each do |name| 
    path = File.join(dir, name)
    if name =~ regex
      ftype = File.directory?(path) ? Dir : File
      begin
        ftype.delete(path)
      rescue SystemCallError => e
        $stderr.puts e.message
      end
    end
  end
end
#---
require 'fileutils'
tmp_dir = 'tmp_buncha_files'
files = ['A', 'A.txt', 'A.html', 'p.html', 'A.html.bak']
directories = ['text.dir', 'Directory.for.html']

Dir.mkdir(tmp_dir) unless File.directory? tmp_dir
files.each { |f| FileUtils.touch(File.join(tmp_dir,f)) }
directories.each { |d| Dir.mkdir(File.join(tmp_dir, d)) }
#---
Dir.entries(tmp_dir)
# => [".", "..", "A", "A.txt", "A.html", "p.html", "A.html.bak", 
#     "text.dir", "Directory.for.html"]

delete_matching_regexp(tmp_dir, /^[A-Z].*\.[^.]{4,}$/)

Dir.entries(tmp_dir)
# => [".", "..", "A", "A.txt", "p.html", "A.html.bak", "text.dir"]
#---
def move_matching_regexp(src, dest, regex)
  Dir.entries(dir).each do |name| 
    File.rename(File.join(src, name), File.join(dest, name)) if name =~ regex
  end
end
#---
def append_matching_regexp(dir, suffix, regex)
  Dir.entries(dir).each do |name| 
    if name =~ regex
      File.rename(File.join(dir, name), File.join(dir, name+suffix)) 
    end
  end
end
#---
def each_matching_regexp(dir, regex)
  Dir.entries(dir).each { |name| yield name if name =~ regex }
end
#---
def append_matching_regexp(dir, suffix, regex)
  each_matching_regexp(dir, regex) do |name|
    File.rename(File.join(dir, name), File.join(dir, name+suffix))
  end
end
#---
def delete_matching_regexp_recursively(dir, regex)
  Find.find(dir) do |path|
    dir, name = File.split(path)
    if name =~ regex
      ftype = File.directory?(path) ? Dir : File
      begin
        ftype.delete(path)
      rescue SystemCallError => e
        $stderr.puts e.message
      end
    end
  end
end
#---
