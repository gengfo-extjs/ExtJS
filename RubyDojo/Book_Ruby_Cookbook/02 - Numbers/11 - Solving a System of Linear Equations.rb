2x + 10y + 8z = 54
7y + 4z = 30
5x + 5y + 5z = 35
#---
require 'matrix'
require 'rational'
coefficients = [[2, 10, 8], [0, 7, 4], [5, 5, 5]].collect! do |row| 
  row.collect! { |x| Rational(x) }
end
coefficients = Matrix[*coefficients]
# => Matrix[[Rational(2, 1), Rational(10, 1), Rational(8, 1)], 
# =>        [Rational(0, 1), Rational(7, 1), Rational(4, 1)], 
# =>        [Rational(5, 1), Rational(5, 1), Rational(5, 1)]]

constants = Matrix[[Rational(54)], [Rational(30)], [Rational(35)]]
#---
solutions = coefficients.inverse * constants
# => Matrix[[Rational(1, 1)], [Rational(2, 1)], [Rational(4, 1)]]
#---
6x    18
-- =  --
6     6
#---
2x + 10y + 8z = 54  |  [ 2 10 8] [x]   [54]
x + 7y + 4z = 31    |  [ 1 7  4] [y] = [31]
5x + 5y + 5z = 35   |  [ 5 5  5] [z]   [35]
#---
matrix = Matrix[[Rational(1), Rational(2)], [Rational(2), Rational(1)]]
matrix.inverse
# => Matrix[[Rational(-1, 3), Rational(2, 3)], 
# =>        [Rational(2, 3), Rational(-1, 3)]]

matrix * matrix.inverse
# => Matrix[[Rational(1, 1), Rational(0, 1)], 
# =>        [Rational(0, 1), Rational(1, 1)]]
#---
matrix = Matrix[[1, 2], [2, 1]]
matrix.inverse
# => Matrix[[-1, 1], 
# =>        [0, -1]]

matrix * matrix.inverse
# => Matrix[[-1, -1], 
# =>        [-2, 1]]
#---
float_matrix = Matrix[[1.0, 2.0], [2.0, 1.0]]
float_matrix.inverse
# => Matrix[[-0.333333333333333, 0.666666666666667], 
# =>        [0.666666666666667, -0.333333333333333]]

float_matrix * float_matrix.inverse
# => Matrix[[1.0, 0.0],
# =>        [1.11022302462516e-16, 1.0]]
#---
