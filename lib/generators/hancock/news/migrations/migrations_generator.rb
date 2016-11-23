require 'rails/generators'
require 'rails/generators/active_record'

module Hancock::News
  class MigrationsGenerator < Rails::Generators::Base
    include ActiveRecord::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)

    desc 'Hancock::News migrations generator'
    def migrations
      if Hancock::News.active_record?
        %w(news).each do |table_name|
          migration_template "migration_#{table_name}.rb", "db/migrate/hancock_news_create_#{table_name}.rb"
        end
      end
    end
  end
end
