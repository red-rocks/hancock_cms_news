module Hancock::News
  module Admin
    module Category
      def self.config(nav_label = nil, fields = {})
        if nav_label.is_a?(Hash)
          nav_label, fields = nav_label[:nav_label], nav_label
        elsif nav_label.is_a?(Array)
          nav_label, fields = nil, nav_label
        end

        Proc.new {
          navigation_label(!nav_label.blank? ? nav_label : I18n.t("hancock.news"))

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle do
              searchable false
            end
            field :name do
              searchable true
            end
            if Hancock::News.config.pages_support and Hancock::News.configuration.can_connect_category_with_pages
              field :connected_pages, :hancock_connectable
            end
            field :add_item do
              pretty_value do
                _model = bindings[:object].item_class.rails_admin_model
                bindings[:view].link_to(
                  'Добавить новость',
                  bindings[:view].new_path(model_name: _model, "#{_model}[category_ids][]": bindings[:object]._id.to_s),
                  class: 'label label-info'
                )
              end
              visible do
                bindings[:controller].action_name == 'index'
              end
              formatted_value {}
            end

            group :content, &Hancock::Admin.content_block
            group :caching, &Hancock::Cache::Admin.caching_block
          end

          edit do
            field :enabled, :toggle
            field :name

            if Hancock::News.config.pages_support and Hancock::News.configuration.can_connect_category_with_pages
              group :connected_pages do
                active false
                field :connected_pages, :hancock_connectable do
                  read_only do
                    !bindings[:view].current_user.admin?
                  end
                end
              end
            end

            group :URL, &Hancock::Admin.url_block
            # group :URL do
            #   active false
            #   field :slugs, :hancock_slugs
            #   field :text_slug
            # end

            if Hancock::News.config.gallery_support
              group :image, &Hancock::Gallery::Admin.images_block([])
              # group :image do
              #   active false
              #   field :image, :hancock_image
              # end
            end


            group :content, &Hancock::Admin.content_block
            # group :content do
            #   active false
            #   field :excerpt, :hancock_html
            #   field :content, :hancock_html
            # end

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            if Hancock::News.config.seo_support
              group :seo_n_sitemap, &Hancock::Seo::Admin.seo_n_sitemap_block
              # group :seo do
              #   active false
              #   field :seo
              # end
              # group :sitemap_data do
              #   active false
              #   field :sitemap_data
              # end
            end

            if Hancock::Pages.config.cache_support
              group :caching, &Hancock::Cache::Admin.caching_block
            end

            group :news do
              active false
              field :news do
                read_only true
                help 'Список новостей'

                pretty_value do
                  bindings[:object].news.to_a.map { |i|
                    route = (bindings[:view] || bindings[:controller])
                    model_name = i.rails_admin_model
                    route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
                  }.join("<br>").html_safe
                end
              end
            end
          end

          show do
            field :name
            field :slugs, :hancock_slugs
            field :text_slug
            field :enabled
            field :image
            field :excerpt
            field :content

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            field :news do
              read_only true

              pretty_value do
                bindings[:object].news.to_a.map { |i|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = i.rails_admin_model
                  route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
