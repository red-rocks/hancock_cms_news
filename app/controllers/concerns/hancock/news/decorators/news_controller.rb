module Hancock::News::Decorators
  module NewsController
    extend ActiveSupport::Concern

    # included do
    #
    #   def category_class
    #     Hancock::News::Category
    #   end
    #   def news_class
    #     Hancock::News::News
    #   end
    #   def page_title
    #     if @news and @news.class == news_class
    #       @news.page_title
    #     else
    #       super
    #     end
    #   end
    #
    #   def per_page
    #     Hancock::News.config.news_per_page
    #   end
    #   def after_initialize
    #   end
    #
    # end

  end
end
