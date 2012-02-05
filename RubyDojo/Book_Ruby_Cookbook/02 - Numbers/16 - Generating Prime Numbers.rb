require 'mathn'
primes = Prime.new
primes.succ                                     # => 2
primes.succ                                     # => 3
#---
primes.each { |x| puts x; break if x > 15; }
# 5
# 7
# 11
# 13
# 17
primes.succ                                     # => 19
#---
def sieve(max=100)
  sieve = []
  (2..max).each { |i| sieve[i] = i }
  (2..Math.sqrt(max)).each do |i|
    (i*i).step(max, i) { |j| sieve[j] = nil } if sieve[i]
  end
  sieve.compact
end

sieve(10)
# => [2, 3, 5, 7]
sieve(100000).size
# => 9592
#---
require 'mathn'

class Prime
  @@primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 
            61, 67, 71, 73, 79, 83, 89, 97, 101]
  @@check_next = 103
#---
  # @@primes[3] < sqrt(@@check_next) < @@primes[4]
  @@limit = 3

  # sqrt(121) == @@primes[4]
  @@increment_limit_at = 121
#---
  def succ
    @index += 1
    while @index >= @@primes.length
      if @@check_next + 4 > @@increment_limit_at
        @@limit += 1
        @@increment_limit_at = @@primes[@@limit + 1] ** 2
      end
      add_if_prime
      @@check_next += 4
      add_if_prime
      @@check_next += 2 
    end
    return @@primes[@index]
  end
#---
  def initialize
    @index = -1    
  end
#---
  :private
  def add_if_prime
    factor = @@primes[2..@@limit].find { |prime| @@check_next % prime == 0 }
    @@primes << @@check_next unless factor
  end
end
#---
primes = Prime.new
p = nil
10000.times { p = primes.succ }
p                                             # => 104729
#---
class Prime
  def prime?(n)
    succ() while @seed < n
    return @primes.member?(n)
  end
end
#---
def probably_prime?(x)
  x < 8
end

probably_prime? 2                          # => true
probably_prime? 5                          # => true
probably_prime? 6                          # => true
probably_prime? 7                          # => true
probably_prime? 8                          # => false
probably_prime? 100000                     # => false
#---
