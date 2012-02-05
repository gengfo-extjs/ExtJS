require 'rubygems'
require 'net/ssh'

def copy_file(session, source_path, destination_path=nil)
  destination_path ||= source_path
  cmd = %{cat > "#{destination_path.gsub('"', '\"')}"}
  session.process.popen3(cmd) do |i, o, e|
    puts "Copying #{source_path} to #{destination_path}... "
    open(source_path) { |f| i.write(f.read) }
    puts 'Done.'
  end
end

Net::SSH.start('example.com', :username=>'leonardr', 
               :password=>'mypass') do |session|
  copy_file(session, '/home/leonardr/scripts/test.rb')
  copy_file(session, '/home/leonardr/scripts/"test".rb')
end
# Copying /home/leonardr/scripts/test.rb to /home/leonardr/scripts/test.rb... 
# Done.
# Copying /home/leonardr/scripts/"test".rb to /home/leonardr/scripts/"test".rb... 
# Done.
#---
def do_copy(session, source_path, destination_path=nil)
  destination_path ||= source_path
  cmd = %{cat > "#{destination_path.gsub('"', '\"')}"}
  cat_process = session.process.open(cmd)

  cat_process.on_success do |p|
    p.write(open(source_path) { |f| f.read })        
    p.close
    puts "Copied #{source_path} to #{destination_path}."
  end  
end
#---
Net::SSH.start('example.com', :username=>'leonardr', 
               :password=>'mypass') do |session|
  do_copy(session, '/home/leonardr/scripts/test.rb')
  do_copy(session, '/home/leonardr/new_index.html', 
                   '/home/leonardr/public_html/index.html')
  session.loop
end
# Copied /home/leonardr/scripts/test.rb to /home/leonardr/scripts/test.rb
# Copied /home/leonardr/new_index.html to /home/leonardr/public_html/index.html
#---
