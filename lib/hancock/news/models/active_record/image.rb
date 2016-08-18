module Hancock::News
  module Models
    module Mongoid
      module Image
        extend ActiveSupport::Concern
        if Hancock::News.config.gallery_support
          included do
            belongs_to :hancock_gallery_imagable, class_name: 'Hancock::News::News'

            validates_lengths_from_database only: [:name]
          end
        end
      end
    end
  end
end
