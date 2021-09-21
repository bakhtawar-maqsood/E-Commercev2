class OrdersController < ApplicationController
  before_action :order_params, only: :create

  def update
    @amount = params[:total_order_cost]
    @user = User.find(params[:user_id])
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken],
    )

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    })

    msg = @user.cart.confirm_order_and_change_status
    redirect_to root_path, notice: msg

    EcommerceMailer.order_details(@user).deliver

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_user_order_charge_path
  end

  def show
    @user = current_user
    @order = @user.cart
    if @order.present?
      @order_items = @order.order_items
    else
      @order_items = nil
    end
  end

  def create
    @user = User.find(params[:user_id])
    @product = Product.find(params[:order][:product_id])
    authorize @product, :add?
    if !@user.orders.present?
      @order = @user.orders.create(order_params)
    elsif @user.cart
      @order = @user.cart
    else
      @order = @user.orders.create(order_params)
    end
    @order_item = @order.order_items.create(product_id: @product.id, quantity: params[:order][:quantity])
    @order_item.add_order_payment
    redirect_to @product, notice: "Added to Cart"
  end

  def destroy
    @user = User.find(params[:user_id])
    @order_item = @user.cart.order_items.find_by(product_id: params[:product_id])
    @order_item.destroy
    redirect_to user_order_path(@user)
  end

  def order_history
    @user = current_user
    @order = @user.placed
  end


  private
  def order_params
    params.require(:order).permit(:user_id)
  end

end


