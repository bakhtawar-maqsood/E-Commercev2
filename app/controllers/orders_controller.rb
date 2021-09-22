class OrdersController < ApplicationController
  before_action :order_params, only: :create
  before_action :find_user, only: [:update, :destroy, :create, :order_history]

  def update
    create_customer
    create_charge
    msg = @user.order_in_cart.confirm_order_and_change_status
    redirect_to root_path, notice: msg
    EcommerceMailer.order_details(@user).deliver
  end

  def show
    @user = current_user
    @order = @user.order_in_cart
    if @order.present?
      @order_items = @order.order_items
    else
      @order_items = nil
    end
  end

  def create
    @product = Product.find(params[:order][:product_id])
    authorize @product, :add?
    if !@user.orders.present?
      @order = @user.orders.create(order_params)
    elsif @user.order_in_cart
      @order = @user.order_in_cart
    else
      @order = @user.orders.create(order_params)
    end
    @order_item = @order.order_items.create(product_id: @product.id, quantity: params[:order][:quantity])
    @order_item.add_order_payment
    redirect_to @product, notice: "Added to Cart"
  end

  def destroy
    @order_item = @user.order_in_cart.order_items.find_by(product_id: params[:product_id])
    @order_item.destroy
    redirect_to user_order_path(@user)
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

  def create_customer
    @customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )
  end

  def create_charge
    Stripe::Charge.create({
      customer: customer.id,
      amount: params[:total_order_cost],
      description: 'Rails Stripe customer',
      currency: 'usd'
    })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_user_order_charge_path
  end

end


