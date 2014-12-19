class CreateRoomTypeVariations < ActiveRecord::Migration
  def change
    create_table :room_type_variations do |t|
      t.integer :room_type_id
      t.boolean :cancellable
      t.integer :cancellation_delay
      t.text :cancellation_details

      t.timestamps
    end
  end
end
