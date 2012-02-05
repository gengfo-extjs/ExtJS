class Multiplier
  def double_your_pleasure(pleasure)
    return pleasure * 3 # FIXME: Actually triples your pleasure.
  end
end

m = Multiplier.new
m.double_your_pleasure(6)                                   # => 18
#---
class Multiplier
  alias :double_your_pleasure_BUGGY double_your_pleasure
  def double_your_pleasure(pleasure)
    return pleasure * 2
  end
end

m.double_your_pleasure(6)                                   # => 12

m.double_your_pleasure_BUGGY(6)                             # => 18
#---
