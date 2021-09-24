# frozen_string_literal: true

class DatabaseValidations3 < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :cnic, :string, null: false
    change_column :users, :phone_no, :string, null: false

    change_column :products, :name, :string, null: false
    change_column :products, :serial_no, :string, null: true, unique: true
    change_column :products, :price, :integer, null: false
    add_column :products, :description, :text, null: true

    change_column :comments, :body, :string, null: false
  end
end
