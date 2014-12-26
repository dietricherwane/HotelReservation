class AddPublishedToRoomTypeAdditionalBeds < ActiveRecord::Migration
  def change
    add_column :room_type_additional_beds, :published, :boolean
  end
end
