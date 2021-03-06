require 'rails/generators'

module Hancock::News
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Hancock::News Config generator'
    def config
      template 'hancock_news.erb', "config/initializers/hancock_news.rb"
    end

  end
end
