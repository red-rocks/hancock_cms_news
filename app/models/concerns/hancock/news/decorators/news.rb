module Hancock::News::Decorators
  module News
    extend ActiveSupport::Concern

    # included do
    #   # after_save :image_auto_rails_admin_jcrop
    #   def image_auto_rails_admin_jcrop
    #     auto_rails_admin_jcrop(:image) # or nil for cancel autocrop
    #   end
    #
    #   # hancock_cms_attached_file(:image)
    #   def image_styles
    #     Hancock::News.configuration.news_image_styles
    #   end
    #
    #   def image_jcrop_options
    #     {}
    #   end
    #
    #   scope :after_now, -> { where(:time.lt => Time.now) }
    #   scope :by_date, -> { desc(:time) }
    #
    #   scope :published, -> { where(published: true) }
    #   scope :publicated, -> { all_of({:publicate_time.lt => Time.now}, {published: true}) }
    #   scope :by_publicate_date, -> { desc(:publicate_time) }
    #
    #   scope :pinned, -> { where(pinned: true) }
    #   scope :pinned_first, -> { desc(:pinned) }
    #
    #   scope :publicated_or_pinned, -> {
    #     any_of({"$and" => [{:publicate_time.lt => Time.now}, {published: true}]}, {pinned: true})
    #   }
    #
    #   scope :after_now_or_pinned, -> {
    #     any_of({:time.lt => Time.now}, {pinned: true})
    #   }
    #
    #
    #   #############   rails_admin ##############
    #   def self.rails_admin_add_fields
    #     {}
    #   end
    #
    #   def self.rails_admin_add_config(config)
    #   end

    #   def admin_can_user_defined_actions
    #     [].freeze
    #   end
    #   def admin_cannot_user_defined_actions
    #     [].freeze
    #   end
    #   def manager_can_user_defined_actions
    #     [].freeze
    #   end
    #   def manager_cannot_user_defined_actions
    #     [].freeze
    #   end
    #   def rails_admin_user_defined_visible_actions
    #     [].freeze
    #   end
    # end

  end
end
