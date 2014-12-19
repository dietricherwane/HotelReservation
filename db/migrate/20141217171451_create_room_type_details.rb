class CreateRoomTypeDetails < ActiveRecord::Migration
  def change
    create_table :room_type_details do |t|
      t.integer :room_detail_id
      t.integer :room_type_id

      t.timestamps
    end
  end
end
