# frozen_string_literal: true

module ApplicationHelper
  def search_results(search_term)
    product_names = Product.search_product(search_term)
  end

  def in_wishlist? product_id
    !current_user&.wishlist&.products&.where(id: product_id)&.empty?
  end

  def in_cart? p_id
    !current_user&.cart&.order_items&.find_by(product_id: p_id).nil?
  end
end
