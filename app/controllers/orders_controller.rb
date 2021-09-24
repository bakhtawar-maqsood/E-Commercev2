# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :order_params, only: :create
  before_action :find_user, only: %i[update destroy create order_history]

  def update
    registration = register_with_stripe_service
    if registration
      msg = @user.order_in_cart.confirm_order_and_change_status
      redirect_to root_path, notice: msg
      EcommerceMailer.order_details(@user).deliver
    else
      redirect_to root_path, notice: 'Cant process at this time'
    end
  end

  def show
    @user = current_user
    @order = @user.order_in_cart
    @order_items = (@order.order_items if @order.present?)
  end

  def create
    @product = Product.find(params[:order][:product_id])
    authorize @product, :add?
    set_order
    add_order_item
    if @order_item
      redirect_to @product, notice: 'Added to Cart'
    else
      redirect_to @product, notice: 'Something went wrong, try again'
    end
  end

  def set_order
    @order = if @user.orders.blank?
               @user.orders.create(order_params)
             elsif @user.order_in_cart
               @user.order_in_cart
             else
               @user.orders.create(order_params)
             end
  end

  def add_order_item
    @order_item = @order.order_items.create(product_id: @product.id, quantity: params[:order][:quantity])
    @order_item.add_order_payment
  end

  def destroy
    @order_item = @user.order_in_cart.order_items.find_by(product_id: params[:product_id])
    if @order_item.destroy
      redirect_to user_order_path(@user), notice: 'Item Deleted'
    else
      redirect_to user_order_path(@user), notice: 'Something went wrong, try again'
    end
  end

  def order_history
    authorize @user, :show_order_history?
    @order = @user.placed_orders
  end

  private

  def order_params
    params.require(:order).permit(:user_id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def register_with_stripe_service
    StripeService.new({
                        email: params[:stripeEmail],
                        card: params[:stripeToken],
                        amount: params[:total_order_cost]
                      }).create_charge
  end
end
