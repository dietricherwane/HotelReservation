class AddPublishedToRoomTypeVariationMiscs < ActiveRecord::Migration
  def change
    add_column :room_type_variation_miscs, :published, :boolean
  end
end
