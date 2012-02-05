require 'rubygems'
require 'RMagick'

img = Magick::Image.read('myimage.jpg').first
width, height = 100, 100
thumb = img.resize(width, height)
thumb.write('mythumbnail.jpg')
#---
scale_factor = 0.15
thumb = img.resize(scale_factor)
thumb.write("mythumbnail.jpg")
#---
def thumb_no_bigger_than(img, width, height)
  img.change_geometry("#{width}x#{height}") do |cols, rows, img|
    img.resize(cols, rows)
  end
end

img.rows                                        # => 470
img.columns                                     # => 892
thumb = thumb_no_bigger_than(img, 100, 100)
thumb.rows                                      # => 53
thumb.columns                                   # => 100
#---
thumb = img.scale(width, height)
thumb = img.scale(scale_factor)
thumb = img.sample(width, height)
thumb = img.sample(scale_factor)
thumb = img.thumbnail(width, height)
thumb = img.thumbnail(scale_factor)
#---
thumb = img.crop(Magick::CenterGravity, 80, 100)
#---
# With an x, y offset relative to the upper-left corner:
thumb = img.crop(x, y, width, height)

# With a GravityType and the x, y offset:
thumb = img.crop(Magick::WestGravity, x, y, width, height)

# With a GravityType:
thumb = img.crop(Magick::EastGravity, width, height)
#---
