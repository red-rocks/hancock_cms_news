module Hancock::News
  module Controllers
    module News
      extend ActiveSupport::Concern

      included do
        if Hancock::News.config.breadcrumbs_on_rails_support
          add_breadcrumb I18n.t('hancock.breadcrumbs.news'), :hancock_news_news_index_path, if: :insert_news_breadcrumbs
        end
      end

      def index
        @news = news_class.enabled.publicated_or_pinned.pinned_first.by_publicate_date
        insert_category_breadcrumbs if insert_breadcrumbs

        unless Hancock::News.config.news_per_page.nil?
          @news = @news.page(params[:page]).per(per_page)
        end

        after_initialize
      end

      def show
        @news = news_class.after_now.find(params[:id])

        if @news and @news.text_slug != params[:id]
          redirect_to hancock_news_news_path(@news), status_code: 301
          return true
        end

        if Hancock::Catalog.config.breadcrumbs_on_rails_support
          insert_category_breadcrumbs if insert_breadcrumbs
          add_breadcrumb @item.name, hancock_catalog_item_path(@item), if: :insert_breadcrumbs
        end

        after_initialize
      end

      private
      def category_class
        Hancock::News::Category
      end
      def news_class
        Hancock::News::News
      end
      def page_title
        if @news.class == news_class
          @news.page_title
        else
          super
        end
      end

      def per_page
        Hancock::News.config.news_per_page
      end
      def after_initialize
      end

      def insert_breadcrumbs
        true
      end
      def insert_news_breadcrumbs
        true
      end
      def insert_category_breadcrumbs
      end

    end
  end
end
