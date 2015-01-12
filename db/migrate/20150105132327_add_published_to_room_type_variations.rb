class AddPublishedToRoomTypeVariations < ActiveRecord::Migration
  def change
    add_column :room_type_variations, :published, :boolean
  end
end
