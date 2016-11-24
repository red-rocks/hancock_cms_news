require 'rails/generators'

module Hancock::News
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../../app/views/hancock/news', __FILE__)
    argument :views_args, type: :array, default: []

    desc 'Hancock::News Config generator'
    def views
      (views_args == ['all'] ? permitted_file_views : ((views_args & permitted_path_views).map { |v| permitted_file_views(v) }.flatten)).each do |v|
        copy_file "#{v}.html.slim", "app/views/hancock/news/#{v}.html.slim"
      end
    end

    private
    def permitted_views
      [
        'categories', 'news',
        'categories/index', 'categories/_list', 'categories/show',
        'news/index',       'news/_list',       'news/show'
      ]
    end

    def permitted_file_views(path = '')
      permitted_views.reject { |v| v.index("#{path}/").nil? }
    end

    def permitted_path_views
      permitted_views.select { |v| v.index('/').nil? }
    end

  end
end
