$KCODE='u'
require 'jcode'
#---
$ ruby -Ku -rjcode
#---
#!/usr/bin/ruby -Ku -rjcode
#---
string = "\xef\xbc\xa1" + "\xef\xbc\xa2" + "\xef\xbc\xa3" +
         "\xef\xbc\xa4" + "\xef\xbc\xa5" + "\xef\xbc\xa6"
#---
string.size                                            # => 18
string.jsize                                           # => 6
#---
string.count "\xef\xbc\xa2"                            # => 13
string.jcount "\xef\xbc\xa2"                           # => 1
#---
"\xef\xbc\xa2".length                                  # => 3
"\xef\xbc\xa2".jlength                                 # => 1
#---
