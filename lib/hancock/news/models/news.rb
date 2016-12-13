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
        # if Hancock::News.config.watermark_support
        #   include Hancock::Gallery::Watermarkable
        # end
      end

      include SmartExcerpt

      include Hancock::News.orm_specific('News')


      included do
        belongs_to :main_category, class_name: "Hancock::News::Category", inverse_of: nil
        before_validation :set_default_main_category
        def set_default_main_category(force = false)
          if force or main_category.blank? or !main_category.enabled and self.respond_to?(:categories)
            self.main_category = self.categories.enabled.sorted.first
          end
        end

        manual_slug :name

        if Hancock::News.config.pages_support and Hancock::News.configuration.can_connect_news_with_pages
          hancock_connectable_field :connected_pages
        end

        if Hancock::News.config.gallery_support and Hancock::News.configuration.news_image_styles
          set_default_auto_crop_params_for(:image)
          hancock_cms_attached_file(:image)
          # if Hancock::News.config.watermark_support
          #   paperclip_with_watermark(:image)
          # else
          #   hancock_cms_attached_file(:image)
          # end
        end

        alias :news_categories :categories

        if Hancock::News.config.gallery_support
        end

        def self.manager_can_add_actions
          ret = []
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::News.mongoid?
          ret << :model_settings if Hancock::News.config.model_settings_support
          ret << :model_accesses if Hancock::News.config.user_abilities_support
          ret << :hancock_touch if Hancock::News.config.cache_support
          ret += [:comments, :model_comments] if Hancock::News.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = []
          ret += [:multiple_file_upload, :sort_embedded] if Hancock::News.mongoid?
          ret << :model_settings if Hancock::News.config.model_settings_support
          ret << :model_accesses if Hancock::News.config.user_abilities_support
          ret << :hancock_touch if Hancock::News.config.cache_support
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
