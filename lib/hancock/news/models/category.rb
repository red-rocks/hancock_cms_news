module Hancock::News
  module Models
    module Category
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


      include Hancock::News.orm_specific('Category')

      include ManualSlug

      included do
        manual_slug :name

        if Hancock::News.config.gallery_support and Hancock::News.configuration.category_image_styles
          hancock_cms_attached_file(:image)
        end

        acts_as_nested_set

        if Hancock::News.config.pages_support and Hancock::News.configuration.can_connect_category_with_pages
          hancock_connectable_field :connected_pages
        end
      end

      def news_class
        Hancock::News::News
      end

      def image_styles
        Hancock::News.configuration.category_image_styles
      end

      def page_title
      end


      def self.manager_default_actions
        super + [:nested_set]
      end

    end
  end
end
