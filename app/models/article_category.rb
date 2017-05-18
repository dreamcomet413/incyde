class ArticleCategory < ActiveRecord::Base

  has_many :articles, foreign_key: :category_id

  def name
    I18n.t("article_category.names.#{code}")
  end

end
