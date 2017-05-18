class AddAttachmentImageToSeminars < ActiveRecord::Migration
  def self.up
    change_table :seminars do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :seminars, :image
  end
end
