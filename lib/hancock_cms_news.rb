unless defined?(Hancock) && Hancock.respond_to?(:orm) && [:active_record, :mongoid].include?(Hancock.orm)
  puts "please use hancock_cms_mongoid or hancock_cms_activerecord"
  puts "also: please use hancock_cms_news_mongoid or hancock_cms_news_activerecord and not hancock_cms_news directly"
  exit 1
end

require "hancock/news/version"
require 'hancock/news/engine'
require 'hancock/news/configuration'

require 'hancock/news/routes'
require 'hancock/news/admin'

require 'smart_excerpt'

# require 'hancock_cms_pages'   if Hancock::News.config.pages_support
# require 'hancock_cms_seo'     if Hancock::News.config.seo_support
# require 'hancock_cms_gallery' if Hancock::News.config.gallery_support

module Hancock::News
  # Hancock::register_plugin(self)

  class << self
    def orm
      Hancock.orm
    end
    def mongoid?
      Hancock::News.orm == :mongoid
    end
    def active_record?
      Hancock::News.orm == :active_record
    end
    def model_namespace
      "Hancock::News::Models::#{Hancock::News.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

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
    autoload :News,             'hancock/news/controllers/news'
    autoload :Categories,       'hancock/news/controllers/categories'
  end

end
