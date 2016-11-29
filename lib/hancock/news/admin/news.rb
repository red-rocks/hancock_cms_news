module Hancock::News
  module Admin
    module News
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t('hancock.news')
          list do
            scopes [:by_date, :enabled, nil]
          end

          field :enabled, :toggle do
            searchable false
          end
          field :pinned, :toggle do
            searchable false
          end
          field :time do
            searchable false
            sort_reverse true
          end
          field :publicate_time do
            searchable false
            sort_reverse true
          end
          field :published do
            searchable false
          end
          field :name do
            searchable true
          end
          field :categories do
            searchable :name
          end
          if Hancock::News.config.pages_support
            group :connected_pages do
              active false
              field :connected_pages, :hancock_connectable
            end
          end
          group :content do
            active false
            field :excerpt, :hancock_html do
              searchable true
            end
            # field :excerpt_html, :ck_editor
            # field :excerpt_clear, :toggle
          end
          group :URL do
            active false
            field :slugs, :hancock_slugs
            field :text_slug do
              searchable true
            end
          end

          list do
            sort_by :publicate_time
          end

          edit do

            if Hancock::News.config.gallery_support
              group :image do
                active false
                field :image, :hancock_image
                field :images
              end
            end

            group :content do
              active false
              field :content, :hancock_html
              # field :content_html, :ck_editor
              # field :content_clear, :toggle
            end

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            if Hancock::News.config.seo_support
              group :seo do
                active false
                field :seo do
                  active true
                end
              end
              group :sitemap_data do
                active false
                field :sitemap_data do
                  active true
                end
              end
            end
          end

          sort_embedded(
              {
                  fields: [:images]
              }
          )

          if defined?(RailsAdminMultipleFileUpload)
            multiple_file_upload(
                {
                    fields: [:images]
                }
            )
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
