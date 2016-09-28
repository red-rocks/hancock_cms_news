module Hancock::News::Decorators
  module Category
    extend ActiveSupport::Concern

    # included do
    #   after_save :image_auto_rails_admin_jcrop
    #   def image_auto_rails_admin_jcrop
    #     auto_rails_admin_jcrop(:image)
    #   end
    #
    #   def image_styles
    #     Hancock::News.configuration.category_image_styles
    #   end
    #
    #   def image_jcrop_options
    #     {}
    #   end
    # end
    #
    #
    # ############# rails_admin ##############
    # def self.rails_admin_add_fields
    #   {}
    # end
    #
    # def self.rails_admin_add_config(config)
    # end

  end
end
