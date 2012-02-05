require 'example'
e = Example::Class.new
e.print_string("Hello World\n")
# Hello World
#---
# example.rb
module Example
  class Class
    def print_string(s)
      print s
    end
  end
end
#---
#include <ruby.h>
#include <stdio.h>

static VALUE rb_mExample;
static VALUE rb_cClass;

static VALUE
print_string(VALUE class, VALUE arg)
{
  printf("%s", RSTRING(arg)->ptr);
  return Qnil;
}

void
Init_example()
{
  rb_mExample = rb_define_module("Example");

  rb_cClass = rb_define_class_under(rb_mExample, "Class", rb_cObject);

  rb_define_method(rb_cClass, "print_string", print_string, 1);
}
#---
# extconf.rb
require 'mkmf'

dir_config('example')
create_makefile('example')
#---
$ ls 
example.c  extconf.rb

$ ruby extconf.rb
creating Makefile

$ make
gcc -fPIC -Wall -g -O2  -fPIC  -I. -I/usr/lib/ruby/1.8/i486-linux 
  -I/usr/lib/ruby/1.8/i486-linux -I.   -c example.c
gcc -shared  -L"/usr/lib" -o example.so example.o  -lruby1.8  
  -lpthread -ldl -lcrypt -lm   -lc

$ ls
Makefile  example.c  example.o  example.so  extconf.rb
#---
require 'example'
e = Example::Class.new
e.print_string("Hello World\n")
# Hello World
#---
static VALUE
write_string(VALUE object, VALUE str)
{
  if (rb_respond_to(object, rb_intern("<<")))
  {
     rb_funcall(object, rb_intern("<<"), 1, str);
  }
  return Qnil;
}
#---
def write_string(object, str)
  object << str if object.respond_to?('<<')
  return nil
end
#---
