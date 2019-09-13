module Hancock::News::NewsPaging
  extend ActiveSupport::Concern

  included do |base|

    if Hancock::News.config.model_settings_support
      model_setting :per_page, kind: :integer, default: Hancock::News.config.news_per_page
      model_setting :sorting_order, kind: :enum, default: "По дате создания (Сначала новые)", possible_hash: sorting_orders
    end
  end

  class_methods do

    def sorting_orders
      {
        "По дате создания (Сначала новые)": {time: :desc},
        "По дате создания (Сначала старые)": {time: :asc},
        "По дате публикации (Сначала новые)": {publicate_time: :desc},
        "По дате публикации (Сначала старые)": {publicate_time: :asc}
      }
    end

    def per_page
      if Hancock::News.config.model_settings_support
        settings.per_page(kind: :integer, default: Hancock::News.config.news_per_page)
      else
        Hancock::News.config.news_per_page
      end
    end

    def sorting_order
      if Hancock::News.config.model_settings_support
        settings.sorting_order(kind: :enum, default: "По дате создания (Сначала новые)", possible_hash: sorting_orders)
      else
        {time: :desc}
      end
    end

  end

end