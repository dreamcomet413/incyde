class AddPdfToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :articles, :pdf
  end
end
