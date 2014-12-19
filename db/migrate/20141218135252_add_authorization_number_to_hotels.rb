class AddAuthorizationNumberToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :authorization_number, :string, limit: 100
  end
end
