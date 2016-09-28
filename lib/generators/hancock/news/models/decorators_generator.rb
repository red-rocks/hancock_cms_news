require 'rails/generators'

module Hancock::News::Models
  class DecoratorsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/models/concerns/hancock/news/decorators', __FILE__)
    argument :models, type: :array, default: []

    desc 'Hancock::News Models generator'
    def decorators
      (models == ['all'] ? permitted_models : models & permitted_models).each do |m|
        copy_file "#{m}.rb", "app/models/concerns/hancock/news/decorators/#{m}.rb"
      end
    end

    private
    def permitted_models
      ['category', 'news', 'image']
    end

  end
end
