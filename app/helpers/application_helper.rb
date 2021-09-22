# frozen_string_literal: true

module ApplicationHelper
  def commenter_name(user_id)
    User.find(user_id).name
  end
  def in_wishlist?(product_id)
    current_user&.wishlist&.products&.where(id: product_id)&.empty?
  end

  def in_cart? p_id
    !current_user&.order_in_cart&.order_items&.find_by(product_id: p_id).nil?
  end
end
