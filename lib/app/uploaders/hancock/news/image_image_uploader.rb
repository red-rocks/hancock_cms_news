# if defined?(Shrine)
#   class Hancock::News::ImageImageUploader < Shrine
if defined?(HancockShrine)
  class Hancock::News::ImageImageUploader < HancockShrine::Uploader
  
    include ::HancockShrine::BaseUploader
    # include ::HancockShrine::Uploadable

  end
end