# frozen_string_literal: true

class AddReferenceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference(:products, :user, index: true, foreign_key: true)
  end
end
