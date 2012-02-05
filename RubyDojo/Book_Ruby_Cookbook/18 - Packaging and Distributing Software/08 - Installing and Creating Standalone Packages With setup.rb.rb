$ ruby setup.rb
#---
$ ruby setup.rb all --installdirs=home
#---
$:
# => ["/home/leonardr/lib/ruby", "/usr/local/lib/site_ruby/1.8", ... ]
require 'installed_via_setup'
# => true
#---
setup.rb
post-clean.rb
lib/
lib/installed_via_setup.rb
lib/pre-config.rb
bin/
bin/command.rb
#---
$ ruby setup.rb clean
---> bin
<--- bin
---> lib
<--- lib
Post-clean hook called.
rm -f .config
rm -f InstalledFiles
#---
$ ruby setup.rb
...
Pre-configuration hook called.
...
rm -f InstalledFiles
---> bin
mkdir -p /usr/bin/
install command.rb /usr/bin/
<--- bin
---> lib
mkdir -p /usr/local/lib/site_ruby/1.8/
install installed_via_setup.rb /usr/local/lib/site_ruby/1.8/
#---
