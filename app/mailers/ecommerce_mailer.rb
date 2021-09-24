# frozen_string_literal: true

class EcommerceMailer < ApplicationMailer
  def price_changed(user)
    @user = user
    mail(to: @user.email, subject: 'NOTICE: Price of item in Wishlist changes')
  end

  def order_details(user)
    @user = user
    @order = @user.orders.last
    mail(to: @user.email, subject: 'ECOMMERCE: YOUR ORDER PLACED!')
  end
end
