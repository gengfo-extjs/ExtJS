$ wget http://www.example.com/gems/my_gem-1.0.4.gem
--10:40:10--  http://www.example.com/gems/my_gem-1.0.4.gem
           => `my_gem-1.0.4.gem'
Resolving gems.example.com... 204.127.202.4
Connecting to gems.example.com|204.127.202.4|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 40,823 (40K) [text/plain]

100%[====================================>] 40,823        46.96K/s

10:40:11 (46.85 KB/s) - `my_gem-1.0.4.gem' saved [40823/40823]

$ gem install ./my_gem-1.0.4.gem
Attempting local installation of './my_gem-1.0.4.gem'
Successfully installed my_gem, version 1.0.4
Installing RDoc documentation for my_gem-1.0.4...
#---
$ gem install --include-dependencies ./my_gem_with_dependency-1.0.0.gem
Attempting local installation of './my_gem_with_dependency.1.0.0.gem'
ERROR: Error installing gem ./my_gem_with_dependency-1.0.0.gem[.gem]:
 my_gem_with_dependency requires my_dependency > 0.0.0
#---
$ cd ~/public_html/
$ mkdir gems
$ cp ~/mygem-1.0.0.gem gems/
$ generate_yaml_index.rb --dir=~/public_html/ --verbose
Building yaml file
   ... adding mygem-1.0.0
Building yaml.Z file
$ ls yaml*
yaml  yaml.Z
#---
