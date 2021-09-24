# frozen_string_literal: true

class HomeController < ApplicationController
  def all_products
    @products = if params[:search_term].nil?
                  Product.all
                else
                  Product.search_product(params[:search_term])
                end
  end
end
