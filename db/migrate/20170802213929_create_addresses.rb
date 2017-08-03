class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :zip_code
      t.string :state
      t.string :country
      t.string :city
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
