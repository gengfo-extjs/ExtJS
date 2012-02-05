#!/usr/bin/ruby -w
# copy.rb
require 'rubygems'
require 'inline'

class Copier
 inline do |builder|
   builder.c <<END
 void copy_file(const char *source, const char *dest) 
 {
   FILE *source_f = fopen(source, "r");
   if (!source_f)
   {
     rb_raise(rb_eIOError, "Could not open source : '%s'", source);
   }

   FILE *dest_f = fopen(dest, "w+");
   if (!dest_f)
   {
     rb_raise(rb_eIOError, "Could not open destination : '%s'", dest);
   }

   char buffer[1024];

   int nread = fread(buffer, 1, 1024, source_f);
   while (nread > 0) 
   {
     fwrite(buffer, 1, nread, dest_f);
     nread = fread(buffer, 1, 1024, source_f);
   }
 }
END
 end
end
#---
open('source.txt', 'w') { |f| f << 'Some text.' }
Copier.new.copy_file('source.txt', 'dest.txt')
puts open('dest.txt') { |f| f.read }
#---
