module Hancock::News
  if Hancock::News.active_record?
    class News < ActiveRecord::Base
    end
  end

  class News
    include Hancock::News::Models::News

    include Hancock::News::Decorators::News

    rails_admin(&Hancock::News::Admin::News.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
