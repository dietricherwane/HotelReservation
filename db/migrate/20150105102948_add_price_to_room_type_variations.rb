class AddPriceToRoomTypeVariations < ActiveRecord::Migration
  def change
    add_column :room_type_variations, :price, :float
  end
end
