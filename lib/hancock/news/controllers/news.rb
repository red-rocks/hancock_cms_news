module Hancock::News
  module Controllers
    module News
      extend ActiveSupport::Concern

      included do
        include Hancock::News::Controllers::Base

        def index
          if Hancock::News.config.breadcrumbs_on_rails_support
            add_breadcrumb(breadcrumbs_news_title, insert_news_index_breadcrumbs) if insert_news_index_breadcrumbs
          end

          @news = news_index_scope

          unless per_page.nil?
            @news = @news.page(params[:page]).per(per_page)
          end

          after_initialize
        end


        def show
          if Hancock::News.config.breadcrumbs_on_rails_support
            add_breadcrumb(breadcrumbs_news_title, insert_news_index_breadcrumbs) if insert_news_index_breadcrumbs
          end

          @news = news_show_scope.find(params[:id])

          if @news and @news.text_slug != params[:id]
            redirect_to hancock_news_news_path(@news), status_code: 301
            return true
          end
          @seo_parent_page = find_seo_page(url_for(action: :index))

          if Hancock::Catalog.config.breadcrumbs_on_rails_support
            add_breadcrumb(@news.name, insert_news_show_breadcrumbs) if insert_news_show_breadcrumbs
          end

          after_initialize
        end



        def page_title
          if @news and @news.class == news_class
            @news.page_title
          else
            super
          end
        end

        def per_page
          Hancock::News.config.news_per_page
        end

      end

    end
  end
end
