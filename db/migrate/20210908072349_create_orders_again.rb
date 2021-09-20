class CreateOrdersAgain < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
        t.references :user, index: true, foreign_key: true
        t.integer :total_cost
        t.integer :status, :default => 0
        t.date :date
        t.timestamps
      end
  end
end
