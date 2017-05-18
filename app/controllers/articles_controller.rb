class ArticlesController < ApplicationController

  include LikeableActions

  load_and_authorize_resource

  before_action :load_article, only: [:show]

  def index
    @category_code = params[:category] || 'incyde'
    @articles = Article.visible_for(current_user).by_category(@category_code).ordered.page(params[:page]).per(20)
  end

  def show
  end

  private

  def load_article
    @article = Article.find(params[:id])
  end
  alias_method :load_resource, :load_article # To use LikeableActions

end
