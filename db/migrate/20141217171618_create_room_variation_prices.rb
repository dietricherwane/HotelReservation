class CreateRoomVariationPrices < ActiveRecord::Migration
  def change
    create_table :room_variation_prices do |t|
      t.integer :room_type_id
      t.float :price
      t.integer :room_type_variation_id

      t.timestamps
    end
  end
end
