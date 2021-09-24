# frozen_string_literal: true

module ApplicationHelper
  def commenter_name(user_id)
    User.find(user_id).name
  end

  def in_wishlist?(user, product_id)
    !user&.wishlist&.products&.find_by(id: product_id).nil?
  end

  def in_cart?(product_id)
    !current_user&.order_in_cart&.order_items&.find_by(product_id: product_id).nil?
  end
end
