# coding: utf-8
module SeoAttachment
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def seo_attachment(options = {})
      before_create :interpolates_file_names
      before_update :interpolates_file_names

      Paperclip.interpolates :normally_file_name do |data, style|
        data.instance.normally_file_name
      end

      class_attribute :seo_attachment_options
      self.seo_attachment_options = {
        :data_name => (options[:data_name] || :data),
        :normally_method => (options[:normally_method] || :slug)
      }

      include SeoAttachment::InstanceMethods
    end
  end

  module InstanceMethods
    def directory
      data_name = seo_attachment_options[:data_name]
      return if self.send(data_name).path.nil?
      data_files = self.send(data_name).path.split("/")
      data_files.delete_at(data_files.size-1)
      data_files.push("*.*").join('/')
    end

    def interpolates_file_names
      data_name = seo_attachment_options[:data_name]
      return if self.send("#{data_name}_file_size").blank?
      normally_file_name = self.send(seo_attachment_options[:normally_method].to_s)
      extension = File.extname(self.send("#{data_name}_file_name")).downcase rescue nil
      old_file = self.send("#{data_name}_file_name")
      new_file = "#{normally_file_name}#{extension}"
      self.send(data_name).instance_write(:file_name, new_file)
      files = Dir[directory]
      files.each do |file|
        dir_array = file.split("/")
        dir_array.pop
        dir = dir_array.join('/')
        prefix = file.split("/").last.split("-")[0]
        was = File.join(dir, "#{prefix}-#{old_file}")
        build = File.join(dir, "#{prefix}-#{new_file}")
        if File.exist?(was) && was != build
          FileUtils.mv was, build
        end
      end
    end
  end
end
