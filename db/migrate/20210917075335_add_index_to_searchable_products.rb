# frozen_string_literal: true

class AddIndexToSearchableProducts < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :products, :searchable, using: :gin, algorithm: :concurrently
  end
end
