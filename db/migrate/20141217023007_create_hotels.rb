class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name, limit: 100
      t.integer :stars
      t.string :address, limit: 100
      t.string :longitude, limit: 50
      t.string :latitude, limit: 50
      t.string :phone_number, limit: 20
      t.string :mobile_number, limit: 20
      t.string :email, limit: 100
      t.string :website, limit: 100
      t.text :description
      t.boolean :published

      t.timestamps
    end
  end
end
