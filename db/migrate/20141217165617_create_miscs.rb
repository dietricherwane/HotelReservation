class CreateMiscs < ActiveRecord::Migration
  def change
    create_table :miscs do |t|
      t.string :description, limit: 100

      t.timestamps
    end
  end
end
