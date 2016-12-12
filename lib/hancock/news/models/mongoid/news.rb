module Hancock::News
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern

        include Hancock::HtmlField

        included do
          index({main_category_id: 1})
          index({category_ids: 1})
          index({related_news_ids: 1})
          index({enabled: 1, time: 1,           pinned: 1, published: 1})
          index({enabled: 1, publicate_time: 1, pinned: 1, published: 1})

          field :name, type: String, localize: Hancock::News.config.localize, default: ""

          field :time, type: Time
          field :published, type: Boolean, default: false
          field :publicate_time, type: Time
          before_save do
            self.publicate_time ||= self.time
          end
          field :pinned, type: Boolean, default: false

          hancock_cms_html_field :excerpt, type: String, localize: Hancock::News.configuration.localize, default: ""
          hancock_cms_html_field :content, type: String, localize: Hancock::News.configuration.localize, default: ""

          has_and_belongs_to_many :categories, class_name: "Hancock::News::Category", inverse_of: nil

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }

          scope :published, -> { where(published: true) }
          scope :publicated, -> { all_of({:publicate_time.lt => Time.now}, {published: true}) }
          scope :by_publicate_date, -> { desc(:publicate_time) }

          scope :pinned, -> { where(pinned: true) }
          scope :pinned_first, -> { desc(:pinned) }

          scope :publicated_or_pinned, -> {
            any_of({"$and" => [{:publicate_time.lt => Time.now}, {published: true}]}, {pinned: true})
          }

          scope :published_or_pinned, -> {
            any_of({published: true}, {pinned: true})
          }

          scope :after_now_or_pinned, -> {
            any_of({:time.lt => Time.now}, {pinned: true})
          }

          if Hancock::News.config.gallery_support
            embeds_many :images, cascade_callbacks: true, class_name: "Hancock::News::Image"
            alias :news_images :images
            accepts_nested_attributes_for :images, allow_destroy: true
          end

          has_and_belongs_to_many :related_news, :class_name => "Hancock::News::News", :inverse_of => :related_news, foreign_key: :related_news_ids

        end

      end
    end
  end
end
