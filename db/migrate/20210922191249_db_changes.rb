class DbChanges < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :commenter
    remove_column :orders, :date
    add_index :orders, :status
    add_index :products, :name
    add_index :products, :serial_no, unique: true
    add_index :products, :price
  end
end
