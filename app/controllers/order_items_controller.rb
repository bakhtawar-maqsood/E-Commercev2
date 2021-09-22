class OrderItemsController < ApplicationController
  before_action :set_data, only: :update

  def update
    if @action == "+"
      @new_quantity = @quantity + 1
      @new_total_cost = @total_cost + @price
    else
      @new_quantity = @quantity - 1
      @new_total_cost = @total_cost - @price
    end
    @order_item.update(quantity: @new_quantity)
    @order.update(total_cost: @new_total_cost)
  end

  def set_data
    @action = params[:order_items][:action]
    @order = Order.find(params[:id])
    @total_cost = @order.total_cost
    @product_id = params[:order_items][:product_id]
    @price = Product.find(@product_id).price
    @order_item = @order.order_items.find_by(product_id: @product_id)
    @quantity = @order_item.quantity
  end

end
