# if defined?(Shrine)
#   class Hancock::News::NewsImageUploader < Shrine
if defined?(HancockShrine)
  class Hancock::News::NewsImageUploader < HancockShrine::Uploader
  
    # include ::HancockShrine::UploaderBase
    include ::HancockShrine::Uploadable

  end
end