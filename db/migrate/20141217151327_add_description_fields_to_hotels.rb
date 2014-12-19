class AddDescriptionFieldsToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :location_description, :text
    add_column :hotels, :rooms_description, :text
    add_column :hotels, :terms, :text
  end
end
