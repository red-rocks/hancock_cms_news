module Hancock::News
  module Models
    module ActiveRecord
      module News
        extend ActiveSupport::Concern
        included do
          if Hancock::News.config.gallery_support
            has_many :images, as: :hancock_gallery_imagable, class_name: 'Hancock::News::Image'
          end

          has_paper_trail

          validates_lengths_from_database only: [:name, :content_html, :excerpt_html]

          scope :after_now, -> { where("time < ?", Time.now) }
          scope :by_date, -> { order(time: :desc) }

          if Hancock::News.config.localize
            translates :name, :content_html, :excerpt_html
          end

          has_and_belongs_to_many :categories,
                                  class_name: "Hancock::News::Category",
                                  join_table: :hancock_news_news_categories
        end
      end
    end
  end
end
