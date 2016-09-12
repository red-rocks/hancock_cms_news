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

        def self.manager_can_add_actions
          ret = []
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::News.mongoid?
          ret << :model_settings if Hancock::News.config.model_settings_support
          ret << :model_accesses if Hancock::News.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::News.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = []
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::News.mongoid?
          ret << :model_settings if Hancock::News.config.model_settings_support
          ret << :model_accesses if Hancock::News.config.user_abilities_support
          ret += [:comments, :model_comments] if Hancock::News.config.ra_comments_support
          ret.freeze
        end
      end

      def image_styles
        Hancock::News.config.news_image_styles
      end

    end
  end
end
