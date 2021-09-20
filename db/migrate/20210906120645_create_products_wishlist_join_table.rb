# frozen_string_literal: true

class CreateProductsWishlistJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :products_wishlists, id: false do |t|
      t.belongs_to :product
      t.belongs_to :wishlist
    end
  end
end
