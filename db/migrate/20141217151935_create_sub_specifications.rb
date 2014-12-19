class CreateSubSpecifications < ActiveRecord::Migration
  def change
    create_table :sub_specifications do |t|
      t.string :description, limit: 100
      t.integer :specification_id
      t.boolean :published

      t.timestamps
    end
  end
end
