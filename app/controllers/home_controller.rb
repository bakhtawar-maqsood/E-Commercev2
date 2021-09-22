# frozen_string_literal: true

class HomeController < ApplicationController
  # frozen_string_literal: trueclass HomeController < ApplicationController
  def all_products
    @products = if params[:search_term].nil?
                  Product.all
                else
                  Product.search_product(params[:search_term])
                end
  end

  def create_cart; end
end
