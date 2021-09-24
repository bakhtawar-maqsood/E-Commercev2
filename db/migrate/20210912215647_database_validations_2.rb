# frozen_string_literal: true

class DatabaseValidations2 < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :address, :string, null: false
  end
end
