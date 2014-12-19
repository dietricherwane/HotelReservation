class CreateRoomTypeVariationMiscs < ActiveRecord::Migration
  def change
    create_table :room_type_variation_miscs do |t|
      t.integer :room_type_variation_id
      t.integer :misc_id

      t.timestamps
    end
  end
end
