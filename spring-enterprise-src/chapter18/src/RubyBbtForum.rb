require 'java'
include_class 'com.baobaotao.service.BbtForum'
class RubyBbtForum < BbtForum
  def setDesc(desc)
    @@desc = desc
  end
  def getDesc
    @@desc;
  end
end
RubyBbtForum.new