Hancock.rails_admin_configure do |config|
  config.action_visible_for :nested_set, 'Hancock::News::Category'

  if Hancock::News.active_record?
    config.action_visible_for :nested_set, 'Hancock::News::Image'
  elsif Hancock::News.mongoid?
    config.action_visible_for :sort_embedded, 'Hancock::News::News'
  end

  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Hancock::News::News'
    config.action_visible_for :comments, 'Hancock::News::Category'
    if Hancock::News.active_record?
      config.action_visible_for :comments, 'Hancock::News::Image'
    end
    config.action_visible_for :model_comments, 'Hancock::News::News'
    config.action_visible_for :model_comments, 'Hancock::News::Category'
    if Hancock::News.active_record?
      config.action_visible_for :model_comments, 'Hancock::News::Image'
    end
  end

  if defined?(RailsAdminMultipleFileUpload)
    if Hancock::News.mongoid?
      config.action_visible_for :multiple_file_upload, 'Hancock::News::News'
    end
  end
end
