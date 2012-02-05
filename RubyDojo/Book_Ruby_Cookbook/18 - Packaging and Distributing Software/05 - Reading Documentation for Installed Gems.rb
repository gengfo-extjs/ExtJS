require 'rubygems'
Gem.manage_gems

def show_gem_rdoc
  puts "Your generated docs are all probably in #{File.join(Gem.dir, "doc")}"

  puts "Just to be safe, I'll print out every gem's RDoc location:"
  specifications_dir = File.join(Gem.dir, 'specifications')
  lacking_rdoc = []
  Gem::SourceIndex.from_installed_gems(specifications_dir).each do |path, spec|
    manager = Gem::DocManager.new(spec)
    if manager.rdoc_installed?
      doc_path = File.join(spec.installation_path, 'doc', spec.full_name)
      puts " #{spec.full_name} => #{doc_path}"
    else
      lacking_rdoc << spec.full_name
    end
  end
  
  unless lacking_rdoc.empty?
    puts "\nThese installed gems have no RDoc installed:"
    puts " #{lacking_rdoc.join("\n ")}"  
  end
end

show_gem_rdoc
# Your generated RDoc is probably all in /usr/lib/ruby/gems/1.8/doc
# Just to be safe, I'll print out every gem's RDoc location:
#  flexmock-0.1.7 => /usr/lib/ruby/gems/1.8/doc/flexmock-0.1.7
#  simple-rss-1.1 => /usr/lib/ruby/gems/1.8/doc/simple-rss-1.1
#  classifier-1.3.0 => /usr/lib/ruby/gems/1.8/doc/classifier-1.3.0
#  actionmailer-1.1.5 => /usr/lib/ruby/gems/1.8/doc/actionmailer-1.1.5
# ...
# 
# These installed gems have no RDoc installed:
#  Ruby-MemCache-0.0.1
#  RedCloth-3.0.4
#  sources-0.0.1
# ...
#---
