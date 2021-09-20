class ChangeTotalCostDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :total_cost, :integer, default: 0
  end
end
