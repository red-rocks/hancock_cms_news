require 'rails/generators'

module Hancock::News::Controllers
  class DecoratorsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/controllers/concerns/hancock/news/decorators', __FILE__)
    argument :controllers, type: :array, default: []

    desc 'Hancock::News Controllers generator'
    def decorators
      (controllers == ['all'] ? permitted_controllers : controllers & permitted_controllers).each do |m|
        m = "news_controller" if m == "news"
        copy_file "#{m}.rb", "app/controllers/concerns/hancock/news/decorators/#{m}.rb"
      end
    end

    private
    def permitted_controllers
      ['categories', 'news']
    end

  end
end
