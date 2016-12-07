module Hancock::News
  module Controllers
    module Base
      extend ActiveSupport::Concern

      included do

        private
        def category_class
          Hancock::News::Category
        end
        def category_scope
          category_class.enabled
        end
        def category_index_scope
          category_scope.sorted
        end
        def category_show_scope
          category_scope
        end

        def news_class(category = nil)
          category ? category.news_class : Hancock::News::News
        end
        def news_scope(category = nil)
          category ? category.news.enabled : news_class.enabled
        end
        def news_index_scope(category = nil)
          news_scope(category).publicated_or_pinned.pinned_first.by_publicate_date
        end
        def news_show_scope(category = nil)
          news_scope(category).publicated_or_pinned
        end

        def after_initialize
        end

        def insert_breadcrumbs
          true
        end
        def insert_categories_index_breadcrumbs
          hancock_news_categories_path if insert_breadcrumbs
        end
        def insert_category_show_breadcrumbs
          hancock_news_category_path(@category) if @category if insert_breadcrumbs
        end
        def insert_news_index_breadcrumbs
          hancock_news_news_index_path if insert_breadcrumbs
        end
        def insert_news_show_breadcrumbs
          hancock_news_news_path(@news) if @news if insert_breadcrumbs
        end

        def breadcrumbs_categories_title
          I18n.t('hancock.breadcrumbs.categories')
        end
        def breadcrumbs_news_title
          I18n.t('hancock.breadcrumbs.news')
        end
      end

    end
  end
end
