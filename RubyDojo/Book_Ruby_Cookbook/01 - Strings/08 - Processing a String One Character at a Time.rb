'foobar'.each_byte { |x| puts "#{x} = #{x.chr}" }
# 102 = f
# 111 = o
# 111 = o
# 98 = b
# 97 = a
# 114 = r
#---
'foobar'.scan( /./ ) { |c| puts c }
# f
# o
# o
# b
# a
# r
#---
"foo\nbar".each { |x| puts x }
# foo
# bar
#---
french = "\xc3\xa7a va"
#---
french.scan(/./) { |c| puts c }
# ร
# ง
# a
# 
# v
# a

french.scan(/./u) { |c| puts c }
# รง
# a
# 
# v
# a

$KCODE = 'u'
french.scan(/./) { |c| puts c }
# รง
# a
# 
# v
# a
#---
