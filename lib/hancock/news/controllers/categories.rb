module Hancock::News
  module Controllers
    module Categories
      extend ActiveSupport::Concern

      included do
        include Hancock::News::Controllers::Base

        def index
          if Hancock::Catalog.config.breadcrumbs_on_rails_support
            add_breadcrumb(breadcrumbs_categories_title, insert_categories_index_breadcrumbs) if insert_categories_index_breadcrumbs
          end

          @categories = category_index_scope.to_a
          @root_news_catalog = category_index_scope.roots.all.to_a

          after_initialize
        end

        def show
          if Hancock::Catalog.config.breadcrumbs_on_rails_support
            add_breadcrumb(breadcrumbs_categories_title, insert_categories_index_breadcrumbs) if insert_categories_index_breadcrumbs
          end

          @category = category_show_scope.find(params[:id])
          if !@category.text_slug.blank? and @category.text_slug != params[:id]
            redirect_to hancock_news_category_path(@category), status_code: 301
            return
          end
          @seo_parent_page = find_seo_page(url_for(action: :index))

          @children = @category.children.enabled.sorted.all.to_a
          # @news = @category.news.enabled.publicated_or_pinned.pinned_first.by_publicate_date.all.to_a
          @news = news_index_scope(@category)

          if Hancock::Catalog.config.breadcrumbs_on_rails_support
            # add_breadcrumb @category.name, -> { insert_category_show_breadcrumbs } if insert_category_show_breadcrumbs
            add_breadcrumb(@category.name, insert_category_show_breadcrumbs)# if insert_category_show_breadcrumbs
          end

          after_initialize
        end



        def page_title
          if @category and @category.class == category_class
            @category.page_title
          else
            super
          end
        end

        def per_page
          Hancock::News.config.categories_per_page
        end

      end

    end
  end
end
