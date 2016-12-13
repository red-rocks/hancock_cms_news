module Hancock::News
  include Hancock::PluginConfiguration

  def self.config_class
    Configuration
  end

  class Configuration
    attr_accessor :news_image_styles
    attr_accessor :category_image_styles
    attr_accessor :images_image_styles

    attr_accessor :categories_per_page

    attr_accessor :news_per_page
    attr_accessor :news_excerpt
    attr_accessor :news_content_required

    attr_accessor :gallery_support
    attr_accessor :seo_support
    attr_accessor :pages_support
    attr_accessor :cache_support

    attr_accessor :breadcrumbs_on_rails_support

    attr_accessor :can_connect_news_with_pages
    attr_accessor :can_connect_category_with_pages

    attr_accessor :localize

    attr_accessor :model_settings_support
    attr_accessor :user_abilities_support
    attr_accessor :ra_comments_support
    attr_accessor :watermark_support

    def initialize
      @news_image_styles = {
          main:  '400x200>',
          thumb: '200x100>'
      }
      @category_image_styles = {
          main:  '400x200>',
          thumb: '200x100>'
      }
      @images_image_styles = {
          main:  '400x200>',
          thumb: '200x100>'
      }

      @categories_per_page = 10

      @news_per_page = 10
      @news_excerpt = 12
      @news_content_required = true

      @gallery_support = defined? Hancock::Gallery
      @seo_support = defined? Hancock::Seo
      @pages_support = defined? Hancock::Pages
      @cache_support  = defined?(Hancock::Cache)

      @breadcrumbs_on_rails_support = defined?(BreadcrumbsOnRails)

      @can_connect_news_with_pages = true
      @can_connect_category_with_pages = true

      @localize = Hancock.config.localize

      @model_settings_support = defined?(RailsAdminModelSettings)
      @user_abilities_support = defined?(RailsAdminUserAbilities)
      @ra_comments_support = defined?(RailsAdminComments)
      @watermark_support = defined?(PaperclipWatermark)
    end
  end
end
