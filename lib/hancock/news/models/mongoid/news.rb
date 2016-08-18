module Hancock::News
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern

        include Hancock::HtmlField

        included do
          field :name, type: String, localize: Hancock::News.config.localize, default: ""

          field :time, type: Time
          index({enabled: 1, time: 1})

          hancock_cms_html_field :excerpt, type: String, localize: Hancock::News.configuration.localize, default: ""
          hancock_cms_html_field :content, type: String, localize: Hancock::News.configuration.localize, default: ""

          has_and_belongs_to_many :categories, class_name: "Hancock::News::Category", inverse_of: nil

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }

          if Hancock::News.config.gallery_support
            embeds_many :images, cascade_callbacks: true, class_name: "Hancock::News::Image"
            accepts_nested_attributes_for :images, allow_destroy: true
          end

        end
      end
    end
  end
end
