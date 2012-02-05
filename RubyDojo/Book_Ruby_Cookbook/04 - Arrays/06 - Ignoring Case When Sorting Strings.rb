list = ["Albania", "anteater", "zorilla", "Zaire"]
list.sort
# => ["Albania", "Zaire", "anteater", "zorilla"]
#---
list.sort_by { |x| x.downcase  }
# => ["Albania", "anteater", "Zaire", "zorilla"]
#---
list.collect { |s| [s.downcase, s] }.sort.collect { |subarray| subarray[1] }

#---
m = {}
list.sort { |x,y| (m[x] ||= x.downcase) <=> (m[y] ||= y.downcase) }
#---
