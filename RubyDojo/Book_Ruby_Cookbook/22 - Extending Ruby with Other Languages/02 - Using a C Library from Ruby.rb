#include "stdio.h"
#include "ruby.h"

static VALUE rb_mStdio;
static VALUE rb_cStdioFile;

struct file 
{
  FILE *fhandle;
};

static VALUE
file_allocate(VALUE klass)
{
  struct file *f = malloc(sizeof(*f));
  f->fhandle = NULL;
  return Data_Wrap_Struct(klass, file_mark, file_free, f);
}

static void 
file_mark(struct file *f)
{
}

static void
file_free(struct file *f)
{
  fclose(f->fhandle);
  free(f);
}
#---
static VALUE
file_open(VALUE object, VALUE fname)
{
  struct file *f;
  Data_Get_Struct(object, struct file, f);
  f->fhandle = fopen(RSTRING(fname)->ptr, "r");
  return Qnil;
}
#---
static VALUE
file_readbyte(VALUE object)
{
  char buffer[2] = { 0, 0 };
  struct file *f;

  Data_Get_Struct(object, struct file, f);

  if (! f->fhandle)
    rb_raise(rb_eRuntimeError, "Attempt to read from closed file");

  fread(buffer, 1, 1, f->fhandle);

  return rb_str_new2(buffer);
}
#---
void
Init_stdio()
{
  rb_mStdio = rb_define_module("Stdio");
  rb_cStdioFile = rb_define_class_under(rb_mStdio, "File", rb_cObject);

  rb_define_alloc_func(rb_cStdioFile, file_allocate);
  rb_define_method(rb_cStdioFile, "open", file_open, 1);
  rb_define_method(rb_cStdioFile, "readbyte", file_readbyte, 0);
}
#---
# extconf.rb
require 'mkmf'
dir_config("stdio")
create_makefile("stdio")
#---
open('foo.txt', 'w') { |f| f << 'foo' }

require 'stdio'
f = Stdio::File.new
f.open('foo.txt')
f.readbyte                                     # => "f"
f.readbyte                                     # => "o"
f.readbyte                                     # => "o"
#---
