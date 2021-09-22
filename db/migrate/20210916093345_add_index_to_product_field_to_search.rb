# frozen_string_literal: true

class AddIndexToProductFieldToSearch < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :name, :string, index: true
    change_column :products, :price, :integer, index: true
    change_column :products, :description, :text, index: true
  end
end
