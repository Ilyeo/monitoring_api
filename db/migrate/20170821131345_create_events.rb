class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :zone_code
      t.string :zone_description
      t.string :event_type
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
