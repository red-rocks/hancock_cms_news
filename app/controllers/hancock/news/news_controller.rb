module Hancock::News
  class NewsController < ApplicationController
    include Hancock::News::Controllers::News

    include Hancock::News::Decorators::NewsController
  end
end
