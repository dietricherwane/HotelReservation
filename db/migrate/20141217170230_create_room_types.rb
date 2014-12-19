class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :name, limit: 100
      t.integer :bed_type_id
      t.text :description
      t.integer :number_of_persons
      t.integer :available_rooms
      t.float :price
      t.boolean :cancellable
      t.integer :cancellation_delay
      t.string :cancellation_details

      t.timestamps
    end
  end
end
