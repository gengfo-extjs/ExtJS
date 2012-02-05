stack = []
1.upto(10) { |x| stack.push(x) }
stack                                  # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
stack.pop                              # => 10
stack                                  # => [1, 2, 3, 4, 5, 6, 7, 8, 9]
#---
queue = []
1.upto(10) { |x| queue.push(x) }
queue                                  # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
queue.shift                            # => 1
queue                                  # => [2, 3, 4, 5, 6, 7, 8, 9, 10]

#---
stack.last                            # => 9
queue.first                           # => 2
#---
values = [1,2,3]
stack1 = values.inject([]) { |stack, x| stack.push(x) }
stack2 = [] + values

stack1                           # => [1, 2, 3]
stack2                           # => [1, 2, 3]
stack1.pop                       # => 3
stack2.pop                       # => 3

#---
