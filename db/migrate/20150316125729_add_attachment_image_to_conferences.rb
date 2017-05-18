class AddAttachmentImageToConferences < ActiveRecord::Migration
  def self.up
    change_table :conferences do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :conferences, :image
  end
end
