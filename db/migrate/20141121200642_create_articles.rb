class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author_type
      t.integer :author_id
      t.string :title
      t.text :description
      t.text :body
      t.boolean :featured, default: false
      t.boolean :public, default: false
      t.string :video_url

      t.timestamps
    end
  end
end
