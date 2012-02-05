require 'rubygems'
require 'RMagick'

img = Magick::Image.read('canyon.png').first
my_text = "\251 NPS"

copyright = Magick::Draw.new
copyright.annotate(img, 0, 0, 3, 18, my_text) do
 self.font = 'Helvetica'
 self.pointsize = 12
 self.font_weight = Magick::BoldWeight
 self.fill = 'white'
 self.gravity = Magick::SouthEastGravity
end
img.write('canyoncopyrighted.png')
#---
require 'rubygems'
require 'RMagick'

img = Magick::Image.read("canyon.png").first
my_text = '\251 NPS'

copyright = Magick::Draw.new
copyright.font = 'Helvetica'
copyright.pointsize = 12
copyright.font_weight = Magick::BoldWeight
copyright.fill = 'white'
copyright.gravity = Magick::SouthEastGravity
copyright.annotate(img, 0, 0, 3, 18, my_text)
img.write('canyoncopyrighted.png')
#---
copyright.annotate(img, 0, 0, 3, 15, my_text)
#---
copyright.gravity = Magick::SouthEastGravity
copyright.annotate(img, 0, 0, 0, 0, my_text)
#---
