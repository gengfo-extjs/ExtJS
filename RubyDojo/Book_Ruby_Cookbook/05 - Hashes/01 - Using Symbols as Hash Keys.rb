people = Hash.new
people[:nickname] = 'Matz'
people[:language] = 'Japanese'
people['last name'.intern] = 'Matsumoto'
people[:nickname]                                              # => "Matz"
people['nickname'.intern]                                      # => "Matz"
#---
'name'.object_id                                               # => -605973716
'name'.object_id                                               # => -605976356
'name'.object_id                                               # => -605978996
#---
:name.object_id                                                # => 878862
:name.object_id                                                # => 878862
'name'.intern.object_id                                        # => 878862
'name'.intern.object_id                                        # => 878862
#---
