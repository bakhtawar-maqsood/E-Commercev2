# frozen_string_literal: true

class AddSearchableColumnsToProducts < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
        ALTER TABLE products
        ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
          setweight(to_tsvector('english', coalesce(name, '')), 'A') ||
          setweight(to_tsvector('english', coalesce(description,'')), 'B')
        ) STORED;
    SQL
  end

  def down
    remove_column :products, :searchable
  end
end
