module Hancock::News
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern

        include Hancock::HtmlField

        included do
          field :name, type: String, localize: Hancock::News.config.localize, default: ""

          field :time, type: Time
          field :publicate_time, type: Time
          before_save do
            self.publicate_time ||= self.time
          end
          field :pinned, type: Boolean, default: false
          index({enabled: 1, publicate_time: 1, time: 1, pinned: 1})

          hancock_cms_html_field :excerpt, type: String, localize: Hancock::News.configuration.localize, default: ""
          hancock_cms_html_field :content, type: String, localize: Hancock::News.configuration.localize, default: ""

          has_and_belongs_to_many :categories, class_name: "Hancock::News::Category", inverse_of: nil

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }

          scope :publicated, -> { where(:publicate_time.lt => Time.now) }
          scope :by_publicate_date, -> { desc(:publicate_time) }

          scope :pinned, -> { where(pinned: true) }
          scope :pinned_first, -> { desc(:pinned) }

          scope :publicated_or_pinned, -> {
            any_of({:publicate_time.lt => Time.now}, {pinned: true})
          }

          scope :after_now_or_pinned, -> {
            any_of({:time.lt => Time.now}, {pinned: true})
          }

          if Hancock::News.config.gallery_support
            embeds_many :images, cascade_callbacks: true, class_name: "Hancock::News::Image"
            accepts_nested_attributes_for :images, allow_destroy: true
          end

        end
      end
    end
  end
end
