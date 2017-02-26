require "hancock/news/version"
require 'hancock/news/engine'
require 'hancock/news/configuration'

require 'hancock/news/routes'
require 'hancock/news/admin'

require 'smart_excerpt'

module Hancock::News
  include Hancock::Plugin

  autoload :Admin,  'hancock/news/admin'
  module Admin
    autoload :News,       'hancock/news/admin/news'
    autoload :Category,   'hancock/news/admin/category'
    autoload :Image,      'hancock/news/admin/image'
  end

  module Models
    autoload :News,       'hancock/news/models/news'
    autoload :Category,   'hancock/news/models/category'
    autoload :Image,      'hancock/news/models/image'

    module Mongoid
      autoload :News,       'hancock/news/models/mongoid/news'
      autoload :Category,   'hancock/news/models/mongoid/category'
      autoload :Image,      'hancock/news/models/mongoid/image'
    end

    module ActiveRecord
      autoload :News,       'hancock/news/models/active_record/news'
      autoload :Category,   'hancock/news/models/active_record/category'
      autoload :Image,      'hancock/news/models/active_record/image'
    end
  end

  module Controllers
    autoload :Base,             'hancock/news/controllers/base'

    autoload :News,             'hancock/news/controllers/news'
    autoload :Categories,       'hancock/news/controllers/categories'
  end

end
