class AddHotelIdToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :hotel_id, :integer
  end
end
