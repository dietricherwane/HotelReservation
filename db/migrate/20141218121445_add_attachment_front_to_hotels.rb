class AddAttachmentFrontToHotels < ActiveRecord::Migration
  def self.up
    change_table :hotels do |t|
      t.attachment :front
    end
  end

  def self.down
    remove_attachment :hotels, :front
  end
end
