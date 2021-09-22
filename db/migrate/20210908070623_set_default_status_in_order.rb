# frozen_string_literal: true

class SetDefaultStatusInOrder < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :status, :string, default: 'in_cart'
  end
end
