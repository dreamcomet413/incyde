class ContentLike < ActiveRecord::Base

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user, uniqueness: {scope: :likeable}

end
