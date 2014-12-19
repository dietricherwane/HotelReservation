class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.string :name, limit: 100
      t.integer :specification_type_id
      t.boolean :published
      t.integer :user_id

      t.timestamps
    end
  end
end
