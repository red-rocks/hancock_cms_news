require 'rails/generators'

module Hancock::News::Models
  class ImageGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string
    argument :news_class_name_arg, type: :string, default: ""

    desc 'Hancock::News Image Model generator'
    def image
      template 'image.erb', "app/models/#{file_name}.rb"
    end

    private
    def capitalized_class_name
      class_name.capitalize
    end

    def camelcased_class_name
      class_name.camelcase
    end

    def file_name
      underscored_class_name
    end

    def underscored_class_name
      camelcased_class_name.underscore
    end

    def underscored_pluralized_class_name
      underscored_class_name.pluralize
    end

    def underscored_news_class_name
      camelcased_news_class_name.underscore
    end

    def underscored_pluralized_news_class_name
      underscored_news_class_name.pluralize
    end

    def camelcased_news_class_name
      news_class_name.camelcase
    end

    def news_class_name
      news_class_name_arg.blank? ? camelcased_class_name.sub(/Image$/, "") : news_class_name_arg
    end
  end
end
