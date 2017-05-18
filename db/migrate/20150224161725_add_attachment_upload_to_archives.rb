class AddAttachmentUploadToArchives < ActiveRecord::Migration
  def self.up
    change_table :archives do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :archives, :upload
  end
end
