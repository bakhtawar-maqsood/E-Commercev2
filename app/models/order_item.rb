# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_destroy :minus_order_payment

  def minus_order_payment
    total_cost = order.total_cost - (product.price * quantity)
    if order.update(total_cost: total_cost)
      order.destroy if order.total_cost == 0
    end
  end

  def add_order_payment
    total_cost = order.total_cost + (product.price * quantity)
    order.update(total_cost: total_cost)
  end
end
