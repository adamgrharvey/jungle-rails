class Admin::DashboardController < ApplicationController
  include HttpAuthConcern

  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"],
                               password: ENV["HTTP_BASIC_PASSWORD"],
                               if: -> { ENV["HTTP_BASIC_PASSWORD"].present? }
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
