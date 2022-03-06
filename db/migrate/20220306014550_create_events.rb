class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.datetime :date
      t.integer :limit
      t.text :detail

      t.timestamps
    end
  end
end
