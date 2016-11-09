module Hancock::News
  module Admin
    module Image
      def self.config(nav_label = nil, fields = {})
        if nav_label.is_a?(Hash)
          fields, nav_label = nav_label, nil
        elsif nav_label.is_a?(Array)
          nav_label, fields = nil, nav_label
        end

        if Hancock::News.config.gallery_support
          if Hancock::News.mongoid?
            if block_given?
              Hancock::Gallery::Admin::EmbeddedImage.config(fields) do |config|
                yield config
              end
            else
              Hancock::Gallery::Admin::EmbeddedImage.config(fields)
            end

          else
            nav_label ||= I18n.t('hancock.news')
            if block_given?
              Hancock::Gallery::Admin::Image.config(nav_label, fields) do |config|
                yield config
              end
            else
              Hancock::Gallery::Admin::Image.config(nav_label, fields)
            end
          end #if Hancock::News.mongoid?
        end #if Hancock::News.config.gallery_support

      end #def self.config(fields = {})

    end #module Image
  end #module Admin
end #module Hancock::News
