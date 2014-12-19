class AddAttachmentIconToMiscs < ActiveRecord::Migration
  def self.up
    change_table :miscs do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :miscs, :icon
  end
end
