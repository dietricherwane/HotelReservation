class AddPublishedToRoomTypes < ActiveRecord::Migration
  def change
    add_column :room_types, :published, :boolean
  end
end
