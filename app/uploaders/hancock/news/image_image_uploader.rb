if defined?(Shrine)
  class Hancock::News::ImageImageUploader < Shrine
  
    include ::HancockShrine::BaseUploader
    # include ::HancockShrine::Uploadable

  end
end