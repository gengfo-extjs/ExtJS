require 'matrix'
require 'mathn'

a1 = [[1, 1, 0, 1],
      [2, 0, 1, 2],
      [3, 1, 1, 2]]
m1 = Matrix[*a1]
# => Matrix[[1, 1, 0, 1], [2, 0, 1, 2], [3, 1, 1, 2]]

a2 = [[1, 0],
      [3, 1],
      [1, 0],
      [2, 2.5]]
m2 = Matrix[*a2]
# => Matrix[[1, 0], [3, 1], [1, 0], [2, 2.5]]

m1 * m2
# => Matrix[[6, 3.5], [7, 5.0], [11, 6.0]]
#---
class Matrix

  def Matrix.multiply(*matrices)
    cache = []
    matrices.size.times { cache << [nil] * matrices.size }
    best_split(cache, 0, matrices.size-1, *matrices)
    multiply_following_cache(cache, 0, matrices.size-1, *matrices)
  end
#---
  :private

  def Matrix.multiply_following_cache(cache, chunk_start, chunk_end, *matrices)
    if chunk_end == chunk_start
      # There's only one matrix in the list; no need to multiply.
      return matrices[chunk_start]
    elsif chunk_end-chunk_start == 1
      # There are only two matrices in the list; just multiply them together.
      lhs, rhs = matrices[chunk_start..chunk_end]
    else
      # There are more than two matrices in the list. Look in the
      # cache to see where the optimal split is located. Multiply
      # together all matrices to the left of the split (recursively,
      # in the optimal order) to get our equation's left-hand
      # side. Similarly for all matrices to the right of the split, to
      # get our right-hand side.
      split_after = cache[chunk_start][chunk_end][1]
      lhs = multiply_following_cache(cache, chunk_start, split_after, *matrices)
      rhs = multiply_following_cache(cache, split_after+1, chunk_end, *matrices)
    end

    # Begin debug code: this illustrates the order of multiplication,
    # showing the matrices in terms of their dimensions rather than their
    # (possibly enormous) contents.
    if $DEBUG
      lhs_dim = "#{lhs.row_size}x#{lhs.column_size}"
      rhs_dim = "#{rhs.row_size}x#{rhs.column_size}"
      cost = lhs.row_size * lhs.column_size * rhs.column_size
      puts "Multiplying #{lhs_dim} by #{rhs_dim}: cost #{cost}"
    end

    # Do a matrix multiplication of the two matrices, whether they are
    # the only two matrices in the list or whether they were obtained
    # through two recursive calls.
    return lhs * rhs
  end
#---
  def Matrix.best_split(cache, chunk_start, chunk_end, *matrices)    
    if chunk_end == chunk_start
      cache[chunk_start][chunk_end] = [0, nil]
   end
    return cache[chunk_start][chunk_end] if cache[chunk_start][chunk_end]
    
    #Try splitting the chunk at each possible location and find the
    #minimum cost of doing the split there. Then pick the smallest of
    #the minimum costs: that's where the split should actually happen.
    minimum_costs = []
    chunk_start.upto(chunk_end-1) do |split_after|
      lhs_cost = best_split(cache, chunk_start, split_after, *matrices)[0]
      rhs_cost = best_split(cache, split_after+1, chunk_end, *matrices)[0]
      
      lhs_rows = matrices[chunk_start].row_size
      rhs_rows = matrices[split_after+1].row_size
      rhs_cols = matrices[chunk_end].column_size
      merge_cost = lhs_rows * rhs_rows * rhs_cols
      cost = lhs_cost + rhs_cost + merge_cost
      minimum_costs << cost
    end
    minimum = minimum_costs.min
    minimum_index = chunk_start + minimum_costs.index(minimum)
    return cache[chunk_start][chunk_end] = [minimum, minimum_index]
  end
end
#---
class Matrix
  # Creates a randomly populated matrix with the given dimensions.
  def Matrix.with_dimensions(rows, cols)
    a = []
    rows.times { a << []; cols.times { a[-1] << rand(10) } }
    return Matrix[*a]
  end

  # Creates an array of matrices that can be multiplied together
  def Matrix.multipliable_chain(*rows)
    matrices = []
    0.upto(rows.size-2) do |i| 
      matrices << Matrix.with_dimensions(rows[i], rows[i+1])
    end
    return matrices
  end  
end
#---
# Create an array of matrices 100x20, 20x10, 10x1.
chain = Matrix.multipliable_chain(100, 20, 10, 1)

# Multiply those matrices two different ways, giving the same result.
Matrix.multiply(*chain) == (chain[0] * chain[1] * chain[2])
# Multiplying 20x10 by 10x1: cost 200
# Multiplying 100x20 by 20x1: cost 2000
#---
# We'll generate the dimensions and contents of the matrices randomly,
# so no one can accuse us of cheating.
dimensions = []
10.times { dimensions << rand(90)+10 }
chain = Matrix.multipliable_chain(*dimensions)

require 'benchmark'
result_1 = nil
result_2 = nil
Benchmark.bm(11) do |b|
  b.report("Unoptimized") do
    result_1 = chain[0]
    chain[1..chain.size].each { |c| result_1 *= c }
  end 
  b.report("Optimized") { result_2 = Matrix.multiply(*chain) }
end
#       user     system      total        real
# Unoptimized  4.350000   0.400000   4.750000 ( 11.104857)
# Optimized    1.410000   0.110000   1.520000 (  3.559470)

# Both multiplications give the same result.
result_1 == result_2                                    # => true
#---
