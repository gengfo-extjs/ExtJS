def sum(*terms) 
  terms.inject(0) { |sum, term| sum + term}
end
#---
# Just a simple file that defines a sum method.

# Takes any number of numeric terms and returns the sum.
#   sum(1, 2, 3)                             # => 6
#   sum(1, -1, 10)                           # => 10
#   sum(1.5, 0.2, 0.3, 1)                    # => 3.0
def sum(*terms) 
  terms.inject(0) { |sum, term| sum + term}
end
#---
$ rdoc
                             sum.rb: .
Generating HTML...

Files:   1
Classes: 0
Modules: 0
Methods: 1
Elapsed: 0.101s
#---
# Takes any number of numeric terms and returns the sum.
#   sum(1, 2, 3)                             # => 6
#---
# =A whirlwind tour of SimpleMarkup
#
# ==You can mark up text
# 
# * *Bold* a single word <b>or a section</b>
# * _Emphasize_ a single word <i>or a section</i>
# * Use a <tt>fixed-width font</tt> for a section or a +word+
# * URLs are automatically linked: https://www.example.com/foo.html 
#
# ==Or create lists
#
# Types of lists:
# * Unordered lists (like this one, and the one above)
# * Ordered lists
#   1. Line
#   2. Square
#   3. Cube
# * Definition-style labelled lists (useful for argument lists)
#   [pos] Coordinates of the center of the circle ([x, y])
#   [radius] Radius of the circle, in pixels
# * Table-style labelled lists
#   Author:: Sophie Aurus
#   Homepage:: http://www.example.com
#---
# This class and its contents are hidden from RDoc; here's what it does:
# ...
#
class HiddenClass # :nodoc:
  # ...
end
#---
class MyClass
  private

  def hidden_method
  end 

  def visible_method # :doc:
  end
end
#---
# The SimplePolynomial class represents polynomials in one variable
# and can perform most common operations on them.
#
# See especially #solve and #derivative. For multivariate polynomials,
# see MultivariatePolynomial (especially
# MultivariatePolynomial#simplify, which may return a
# SimplePolynomial), and much of calculus.rb.
#---
#!/usr/bin/ruby
# rdoc.rb
require 'rdoc/rdoc'
RDoc::RDoc.new.document(ARGV)
#---
