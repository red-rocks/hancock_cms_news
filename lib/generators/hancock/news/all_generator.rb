require 'rails/generators'

module Hancock::News
  class AllGenerator < Rails::Generators::Base
    argument :class_name, type: :string

    desc 'Hancock::News generator'
    def all
      generate "hancock:news:config:install"

      generate "hancock:news:models:all #{class_name}"

      generate "hancock:news:controllers:all #{class_name}"
    end

  end
end
