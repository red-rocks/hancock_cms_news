module Hancock::News
  module Models
    module News
      extend ActiveSupport::Concern
      include Hancock::Model
      include Hancock::Enableable
      include Hancock::HtmlField
      include ManualSlug

      if Hancock::News.config.seo_support
        include Hancock::Seo::Seoable
        include Hancock::Seo::SitemapDataField
      end
      if Hancock::News.config.pages_support
        include Hancock::Pages::Connectable
      end
      if Hancock::News.config.gallery_support
        include Hancock::Gallery::Paperclipable
      end

      include SmartExcerpt

      include Hancock::News.orm_specific('News')


      included do

        manual_slug :name

        if Hancock::News.config.pages_support and Hancock::News.configuration.can_connect_news_with_pages
          hancock_connectable_field :connected_pages
        end

        if Hancock::News.config.gallery_support and Hancock::News.configuration.news_image_styles
          hancock_cms_attached_file(:image)
        end

        alias :news_categories :categories

        if Hancock::News.config.gallery_support
          alias :news_images :images
          accepts_nested_attributes_for :images, allow_destroy: true
        end
      end

      def image_styles
        Hancock::News.config.news_image_styles
      end


      def self.manager_default_actions
        if Hancock::News.config.mongoid?
          _add = [:multiple_file_upload, :sort_embedded]
        else
          _add = []
        end
        super + _add
      end
    end
  end
end
