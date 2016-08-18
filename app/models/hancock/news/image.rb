if Hancock::News.config.gallery_support
  module Hancock::News
    _parent_class = Hancock::Gallery::Image if Hancock::News.active_record?
    _parent_class = Hancock::Gallery::EmbeddedImage if Hancock::News.mongoid?

    class Image < _parent_class
      include Hancock::News::Models::Image

      include Hancock::News::Decorators::Image

      rails_admin(&Hancock::News::Admin::Image.config(nil, rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
