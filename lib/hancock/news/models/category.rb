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
          set_default_auto_crop_params_for(:image)
          hancock_cms_attached_file(:image)
          # if Hancock::News.config.watermark_support
          #   paperclip_with_watermark(:image)
          # else
          #   hancock_cms_attached_file(:image)
          # end
        end

        acts_as_nested_set

        if Hancock::News.config.pages_support and Hancock::News.configuration.can_connect_category_with_pages
          hancock_connectable_field :connected_pages
        end

        def self.manager_can_add_actions
          ret = [:nested_set]
          # ret += [:multiple_file_upload, :sort_embedded] if Hancock::News.mongoid?
          ret << :model_settings if Hancock::News.config.model_settings_support
          ret << :model_accesses if Hancock::News.config.user_abilities_support
          ret << :hancock_touch if Hancock::News.config.cache_support
          ret += [:comments, :model_comments] if Hancock::News.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = [:nested_set]
          # ret += [:multiple_file_upload, :sort_embedded] if Hancock::News.mongoid?
          ret << :model_settings if Hancock::News.config.model_settings_support
          ret << :model_accesses if Hancock::News.config.user_abilities_support
          ret << :hancock_touch if Hancock::News.config.cache_support
          ret += [:comments, :model_comments] if Hancock::News.config.ra_comments_support
          ret.freeze
        end

        def self.news_class
          Hancock::News::News
        end

        def news_class
          self.class.news_class
        end

        def image_styles
          Hancock::News.configuration.category_image_styles
        end

      end

    end
  end
end
