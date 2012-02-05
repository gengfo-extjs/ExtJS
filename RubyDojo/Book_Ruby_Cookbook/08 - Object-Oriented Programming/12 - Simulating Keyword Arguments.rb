def fun_with_text(text, args={})
  text = text.upcase if args[:upcase]
  text = text.downcase if args[:downcase]
  if args[:find] and args[:replace]
    text = text.gsub(args[:find], args[:replace]) 
  end
  text = text.slice(0, args[:truncate_at]) if args[:truncate_at]
  return text
end
#---
fun_with_text("Foobar", {:upcase => true, :truncate_at => 5})
# => "FOOBA"
fun_with_text("Foobar", :upcase => true, :truncate_at => 5)
# => "FOOBA"

fun_with_text("Foobar", :find => /(o+)/, :replace => '\1d', :downcase => true)
# => "foodbar"
#---
###
# This mix-in module lets methods match a caller's hash of keyword
# parameters against a hash the method keeps, mapping keyword
# arguments to default parameter values.
#
# If the caller leaves out a keyword parameter whose default value is
# :MANDATORY (a constant in this module), then an error is raised.
#
# If the caller provides keyword parameters which have no
# corresponding keyword arguments, an error is raised.
#
module KeywordProcessor
  MANDATORY = :MANDATORY

  def process_params(params, defaults)
    # Reject params not present in defaults.
    params.keys.each do |key|
      unless defaults.has_key? key
        raise ArgumentError, "No such keyword argument: #{key}"
      end
    end
    result = defaults.dup.update(params)

    # Ensure mandatory params are given.
    unfilled = result.select { |k,v| v == MANDATORY }.map { |k,v| k.inspect }
    unless unfilled.empty?
      msg = "Mandatory keyword parameter(s) not given: #{unfilled.join(', ')}"
      raise ArgumentError, msg
    end

    return result
  end
end
#---
class TextCanvas
  include KeywordProcessor

  def render(text, args={})
    args = process_params(args, {:font => 'New Reykjavik Solemn', :size => 36, 
                                 :bold => false, :x => :MANDATORY, 
                                 :y => :MANDATORY }.freeze)
    # ...    
    puts "DEBUG: Found font #{args[:font]} in catalog."
    # ...
  end
end

canvas = TextCanvas.new

canvas.render('Hello', :x => 4, :y => 100)
# DEBUG: Found font New Reykjavik Solemn in catalog.

canvas.render('Hello', :x => 4, :y => 100, :font => 'Lacherlich')
# DEBUG: Found font Lacherlich in catalog.

canvas.render('Hello', :font => "Lacherlich")
# ArgumentError: Mandatory keyword parameter(s) not given: :x, :y

canvas.render('Hello', :x => 4, :y => 100, :italic => true)
# ArgumentError: No such keyword argument: italic
#---
