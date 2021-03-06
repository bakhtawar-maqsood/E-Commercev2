# frozen_string_literal: true

class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
