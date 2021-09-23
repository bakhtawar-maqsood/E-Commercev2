class Dbhhh < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :date, :date
  end
end
