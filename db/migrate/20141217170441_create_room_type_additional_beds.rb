class CreateRoomTypeAdditionalBeds < ActiveRecord::Migration
  def change
    create_table :room_type_additional_beds do |t|
      t.integer :room_type_id
      t.integer :additional_bed_type_id

      t.timestamps
    end
  end
end
