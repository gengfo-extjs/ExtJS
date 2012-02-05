%module libc

FILE *fopen(const char *, const char *);

int fread(void *, size_t, size_t, FILE *);
int fwrite(void *, size_t, size_t, FILE *);
int fclose(FILE *);

void *malloc(size_t);
#---
# extconf.rb
require 'mkmf'
dir_config('tcl')
dir_config('libc')
create_makefile('libc')
#---
$ swig -ruby libc.i
$ ls
extconf.rb  libc.i  libc_wrap.c

$ ruby extconf.rb --with-tcl-include=/usr/include/tcl8.4
creating Makefile

$ make
...

$ ls
Makefile  extconf.rb  libc.i  libc.so  libc_wrap.c  libc_wrap.o
#---
random_data = ""
10000.times { random_data << rand(255) }
open('source.txt', 'w') { |f| f << random_data }

require 'libc'
f1 = Libc.fopen('source.txt', 'r')
f2 = Libc.fopen('dest.txt', 'w+')

buffer = Libc.malloc(1024)

nread = Libc.fread(buffer, 1, 1024, f1)

while nread > 0
 Libc.fwrite(buffer, 1, nread, f2)
 nread = Libc.fread(buffer, 1, 1024, f1)
end
Libc.fclose(f1)
Libc.fclose(f2)

# dest.txt now contains the same random data as source.txt.
random_data == open('dest.txt') { |f| f.read }
# => true
#---
