#!/usr/bin/env jruby
# random.jrb
require 'java'
include_class 'java.util.Random'

r = Random.new(123)
puts "Some random number #{r.nextInt % 10}"
r.seed = 456
puts "Another random number #{r.nextInt % 10}"
#---
$ jruby random.jrb
Some random number 9
Another random number 0
#---
include_class('java.lang.String') { |package,name| "J" + name }
#---
class Foo 
{
  public void bar(int arg) {...}
  public void bar(long arg) {...}
}
#---
  Foo.new.bar(5)
#---
setSeed(value);
#---
seed = value
#---
