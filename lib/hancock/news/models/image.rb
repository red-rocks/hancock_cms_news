module Hancock::News
  module Models
    module Image
      extend ActiveSupport::Concern

      include Hancock::News.orm_specific('Image')

      included do
      end

      def image_styles
        Hancock::News.configuration.images_image_styles
      end
    end
  end
end
