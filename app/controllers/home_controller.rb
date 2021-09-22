class HomeController < ApplicationController

# frozen_string_literal: trueclass HomeController < ApplicationController
  def all_products
    if params[:search_term].nil?
      @products = Product.all
    else
      @products = Product.search_product(params[:search_term])
    end
  end

end
