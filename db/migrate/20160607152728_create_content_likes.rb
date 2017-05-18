class CreateContentLikes < ActiveRecord::Migration
  def change
    create_table :content_likes do |t|
      t.references :user, index: true
      t.references :likeable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
