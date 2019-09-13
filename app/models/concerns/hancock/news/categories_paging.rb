module Hancock::News::CategoriesPaging
  extend ActiveSupport::Concern

  included do

    if Hancock::News.config.model_settings_support
      model_setting :per_page, kind: :integer, default: Hancock::News.config.categories_per_page
      model_setting :news_per_page, kind: :integer, default: Hancock::News.config.news_per_page
      model_setting :news_sorting_order, kind: :enum, default: "По дате создания (Сначала новые)", possible_hash: news_sorting_orders
    end
    
  end


  class_methods do
  
    def news_sorting_orders
      {
        "По дате создания (Сначала новые)": {time: :desc},
        "По дате создания (Сначала старые)": {time: :asc},
        "По дате публикации (Сначала новые)": {publicate_time: :desc},
        "По дате публикации (Сначала старые)": {publicate_time: :asc}
      }
    end

    def per_page
      if Hancock::News.config.model_settings_support
        settings.per_page(kind: :integer, default: Hancock::News.config.categories_per_page)
      else
        Hancock::News.config.categories_per_page
      end
    end

    def news_per_page
      if @category
        @category
      else
        if Hancock::News.config.model_settings_support
          settings.per_page(kind: :integer, default: Hancock::News.config.news_per_page)
        else
          Hancock::News.config.categories_per_page
        end
      end
    end

    def news_sorting_order
      if @category
        # Hancock::News::News.settings.per_page(kind: :enum, default: "По дате создания (Сначала новые)", possible_hash: news_sorting_orders)
      else
        if Hancock::News.config.model_settings_support
          settings.news_sorting_order(kind: :enum, default: "По дате создания (Сначала новые)", possible_hash: news_sorting_orders)
        else
          {time: :desc}
        end
      end
    end

  end

end