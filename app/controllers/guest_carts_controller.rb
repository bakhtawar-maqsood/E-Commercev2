class GuestCartsController < ApplicationController
  before_action :cart_index, only: :add
  before_action :authenticate_user!, only: :update

  def create
    order = Hash.new
    order = { cart_index => {quantity: params[:guest_carts][:quantity], product_id: params[:guest_carts][:product_id]}}
    if session[:order].nil?
      session[:order] = order
    else
      session[:order] = session[:order].merge(order)
    end
    redirect_to root_path, notice: "Added to Cart"
  end

  def show
    @order_items = []
    @total_cost = 0
    unless session[:order].nil?
      session[:order].each do |product_details|
        product_id = product_details[1]["product_id"]
        quantity = product_details[1]["quantity"]
        order_item = [product_id, quantity]
        @order_items << order_item
        @total_cost = @total_cost + (Product.find(product_id).price * quantity.to_i)
        session[:total_cost] = @total_cost
      end
    end
    @order_items
  end

  def cart_index
    return 0 if session[:order].nil?
    session[:order].count
  end
end
