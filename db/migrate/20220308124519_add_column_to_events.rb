class AddColumnToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :restaurant_id, :integer
  end
end
