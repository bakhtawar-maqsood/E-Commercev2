# frozen_string_literal: true

class DropOrders < ActiveRecord::Migration[5.2]
  def change
    drop_table :order_items
    drop_table :orders
  end
end
