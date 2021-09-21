# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  enum status: { in_cart: 0, placed: 1, delivered: 2 }



  before_create :set_date_and_status

  def confirm_order_and_change_status
    @user = User.find(self.user_id)
    msg = ""
    if self.update(status: 1)
        if @user.orders.count == 1
          self.bonus
          return msg = "Congratulations! You have got 5% redeem on your First order"
        else
          return msg = "Order Placed"
        end
    end
  end

  def bonus
    payable = total_cost - (5 * total_cost) /100
    self.update(total_cost: payable)
  end

  def transfer_guest_cart_to_orders(session_items)
    session_items.each do |session_item|
      p_id = session_item[1]["product_id"]
      q = session_item[1]["quantity"]
      product = Product.find(p_id)
      unless self.user_id == product.user_id
        @order_item = self.order_items.create(product_id: p_id, quantity: q)
      else
        self.update(total_cost: self.total_cost-(product.price * q.to_i))
      end
    end
  end

  private
  def set_date_and_status
    if :status.nil?
      self.status = 0
    end
    self.date = Date.today
  end




end