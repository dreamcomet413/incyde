class AddImageUrlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :image_url, :string, limit: 1000
    add_column :articles, :imported_url, :string, limit: 1000
  end
end
