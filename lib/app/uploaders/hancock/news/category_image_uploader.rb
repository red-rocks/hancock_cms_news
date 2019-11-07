# if defined?(Shrine)
#   class Hancock::News::CategoryImageUploader < Shrine
if defined?(HancockShrine)
  class Hancock::News::CategoryImageUploader < HancockShrine::Uploader
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end