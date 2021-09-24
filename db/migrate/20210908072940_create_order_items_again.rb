# frozen_string_literal: true

class CreateOrderItemsAgain < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true, index: true
      t.references :product, foreign_key: true, index: true
      t.integer :quantity
      t.timestamps
    end
  end
end
