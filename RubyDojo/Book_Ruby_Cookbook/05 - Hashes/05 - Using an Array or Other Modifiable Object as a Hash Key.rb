coordinates = [10, 5]
treasure_map = { coordinates => 'jewels' }
treasure_map[coordinates]                    # => "jewels"

# Add a z-coordinate to indicate how deep the treasure is buried.
coordinates << -5

coordinates                                  # => [10, 5, -5]
treasure_map[coordinates]                    # => nil
# Oh no!
#---
treasure_map.rehash
treasure_map[coordinates]                    # => "jewels"
#---
module ReliablyHashable
  def hash
    return object_id
  end
end

class ReliablyHashableArray < Array
  include ReliablyHashable
end
#---
coordinates = ReliablyHashableArray.new([10,5])
treasure_map = { coordinates => 'jewels' }
treasure_map[coordinates]                          # => "jewels"

# Add a z-coordinate to indicate how deep the treasure is buried.
coordinates.push(-5)

treasure_map[coordinates]                          # => "jewels"
#---
a = [1,2]
b = a.clone
a.hash                                    # => 11
b.hash                                    # => 11

a  = ReliablyHashableArray.new([1,2])
b = a.clone
a.hash                                    # => -606031406
b.hash                                    # => -606034266
#---
