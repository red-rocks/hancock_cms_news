module Hancock::News
  class Category
    include Hancock::News::Models::Category

    include Hancock::News::Decorators::Category

    rails_admin(&Hancock::News::Admin::Category.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
