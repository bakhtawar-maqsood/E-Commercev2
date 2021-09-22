# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :order_params, only: :create
  before_action :set_user, only: [:update, :create, :destroy, :order_history]

  def update
    create_customer
    create_charge
    msg = @user.cart.confirm_order_and_change_status
    redirect_to root_path, notice: msg

    EcommerceMailer.order_details(@user).deliver
  end

  def show
    @user = current_user
    @order = @user.cart
    @order_items = (@order.order_items if @order.present?)
  end

  def create
    @product = Product.find(params[:order][:product_id])
    authorize @product, :add?
    @order = if @user.orders.blank?
               @user.orders.create(order_params)
             elsif @user.cart
               @user.cart
             end
    @order_item = @order.order_items.create(product_id: @product.id, quantity: params[:order][:quantity])
    @order_item.add_order_payment
    redirect_to @product, notice: 'Added to Cart'
  end

  def destroy

    @order_item = @user.cart.order_items.find_by(product_id: params[:product_id])
    @order_item.destroy
    redirect_to user_order_path(@user)
  end

  def order_history
    authorize @user, :show_order_history?
    @order = @user.placed
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def order_params
    params.require(:order).permit(:user_id)
  end

  def create_customer
    @customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
  end

  def create_charge
    Stripe::Charge.create({
      customer: @customer.id,
      amount: params[:total_order_cost],

      description: 'Rails Stripe customer',
      currency: 'usd'
    })
  end
end
