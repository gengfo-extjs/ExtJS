require 'rubygems'
require 'RMagick'

img = Magick::Image.read('myimage.png').first
img.write('myimage.jpg')
#---
Magick::Image.read('JPG:myimage.png')
# Magick::ImageMagickError: Not a JPEG file: starts with 0x89 0x50 `myimage.png': 
#---
img = Magick::Image.read('myimage.png').first
img.write('myimage.jpg')          # Writes a JPEG
img.write('myimage.gif')          # Writes a GIF
img.write('JPG:myimage')          # Writes a JPEG
img.write('JPG:myimage.gif')      # Writes a JPEG
#---
img.format                        # => "PNG"
img.format = 'GIF'
img.format                        # => "GIF"
#---
Magick.formats['GIF']                    # => "*rw+"
Magick.formats['JPG']                    # => "*rw-"
Magick.formats['AVI']                    # => "*r--"
Magick.formats['PS']                     # => " rw+"
#---
module Magick
 [['native_blob?', ?*], ['readable?', ?r],
  ['writable?', ?w], ['multi_image?', ?+]].each_with_index do |m, i|
   define_method(m[0]) do |format|
     code = formats[format]
     return code && code[i] == m[1]
   end
   module_function(m[0])
 end
end
#---
Magick.multi_image? 'GIF'                           # => true
Magick.multi_image? 'JPG'                           # => false
#---
