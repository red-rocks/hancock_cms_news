module Hancock::News
  module Controllers
    module News
      extend ActiveSupport::Concern

      included do
        include Hancock::News::Controllers::Base

        def index

          @category = category_scope.find(params[:category_id]) if params[:category_id].present?

          @news = news_index_scope(@category)

          unless per_page.nil?
            @news = @news.page(params[:page]).per(per_page)
          end

          after_initialize
          if Hancock::News.config.breadcrumbs_on_rails_support
            add_breadcrumb(breadcrumbs_news_title, insert_news_index_breadcrumbs) if insert_news_index_breadcrumbs
          end
        end


        def show

          @category = category_scope.find(params[:category_id]) if params[:category_id].present?

          @news = news_show_scope(@category).find(params[:id])

          if @news and @news.text_slug != params[:id]
            redirect_to hancock_news_news_path(@news), status_code: 301
            return true
          end
          @seo_parent_page = find_seo_page(url_for(action: :index))

          if Hancock::News.config.breadcrumbs_on_rails_support
            add_breadcrumb(@news.name, insert_news_show_breadcrumbs) if insert_news_show_breadcrumbs
          end

          after_initialize
          if Hancock::News.config.breadcrumbs_on_rails_support
            add_breadcrumb(breadcrumbs_news_title, insert_news_index_breadcrumbs) if insert_news_index_breadcrumbs
          end
        end



        def page_title
          if @news and @news.class == news_class
            @news.page_title
          else
            super
          end
        end

        def per_page
          news_class.per_page
        end

      end

    end
  end
end
