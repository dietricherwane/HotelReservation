class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name, limit: 100
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
