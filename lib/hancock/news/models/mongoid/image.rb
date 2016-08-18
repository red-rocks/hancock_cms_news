module Hancock::News
  module Models
    module Mongoid
      module Image
        extend ActiveSupport::Concern
        if Hancock::News.config.gallery_support

          included do
            embedded_in :news, class_name: "Hancock::News::News"
          end

          include ::Mongoid::EmbeddedFindable
          module ClassMethods
            def find(id)
              find_through(Hancock::News::News, 'images', id)
            end
          end
        end
      end
    end
  end
end
