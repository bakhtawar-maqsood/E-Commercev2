# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :cnic, :address, :phone_no, :password, :avatar)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :cnic, :address, :phone_no, :email, :password, :current_password, :avatar)
    end
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || user_products_path(@user))
  end

  def after_sign_in_path_for(_resource)
    if session[:order].nil?
      root_path
    else
      if current_user&.cart.nil?
        @order = current_user.orders.create(total_cost: session[:total_cost], status: 0)
      else
        t_cost = current_user.cart.total_cost
        current_user.cart.update(total_cost: t_cost + session[:total_cost])
        @order = current_user.cart
      end
      @order.transfer_guest_cart_to_orders(session[:order])
      flash[:notice] = 'Logged In! Now you can checkout'
      user_order_path(@user)
    end
  end
end
