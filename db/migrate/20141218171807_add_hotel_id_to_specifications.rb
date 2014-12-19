class AddHotelIdToSpecifications < ActiveRecord::Migration
  def change
    add_column :specifications, :hotel_id, :integer
  end
end
