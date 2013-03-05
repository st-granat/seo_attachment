# coding: utf-8
class String
  def remove_extension
    File.basename(self, '.*')
  end
end
