class AddPublishedToMiscs < ActiveRecord::Migration
  def change
    add_column :miscs, :published, :boolean
  end
end
