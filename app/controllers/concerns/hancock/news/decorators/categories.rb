module Hancock::News::Decorators
  module Categories
    extend ActiveSupport::Concern

    # included do
    #
    #   def after_initialize
    #   end
    #
    #   def category_class
    #     Hancock::News::Category
    #   end
    #   def news_class
    #     Hancock::News::News
    #   end
    #   def page_title
    #     if @category and @category.class == category_class
    #       @category.page_title
    #     else
    #       super
    #     end
    #   end
    #
    #   def insert_breadcrumbs
    #     true
    #   end
    #
    # end

  end
end
