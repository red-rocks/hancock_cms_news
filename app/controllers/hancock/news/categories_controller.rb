module Hancock::News
  class CategoriesController < ApplicationController
    include Hancock::News::Controllers::Categories

    include Hancock::News::Decorators::Categories
  end
end
