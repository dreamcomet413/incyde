module LikeableActions

  extend ActiveSupport::Concern

  def toggle_like
    resource = load_resource
    content_like = current_user.content_likes.find_or_initialize_by(likeable: resource)
    if content_like.new_record?
      content_like.save
    else
      content_like.destroy
    end
    redirect_to :back
  end

end
