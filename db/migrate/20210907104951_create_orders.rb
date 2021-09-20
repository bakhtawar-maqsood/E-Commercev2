# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :total_cost
      t.integer :status
      t.date :date
      t.timestamps
    end
  end
end
