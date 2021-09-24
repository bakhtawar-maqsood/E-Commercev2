# frozen_string_literal: true

class DbChanges < ActiveRecord::Migration[5.2]
  def change
    add_index :orders, :status
    add_index :products, :name
    add_index :products, :serial_no, unique: true
    add_index :products, :price
  end
end
