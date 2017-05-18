class Seminar < ActiveRecord::Base

  belongs_to :author, polymorphic: true

  validates :author, presence: true
  validates :name, presence: true
  validates :url, presence: true
  validates :start_at, presence: true

  has_attached_file :image, :styles => { :medium => "360x240>", :thumb => "100x100>" } #, :default_url => "placeholder-image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active, -> {where("start_at >= ?", Time.now - 2.hours)} # TODO revisar que en produción se actializa en now y no se cachea
  scope :next, -> (n = 3) {where("start_at >= ?", Time.now - 2.hours).order("start_at asc").limit(n)}
  scope :visible_for, -> (user){
    if user.is_a?(Admin)
      all
    elsif user.is_a?(BusinessIncubator)
      where("author_type = 'Admin' OR (author_type = 'BusinessIncubator' AND author_id = ?)", user.id)
    elsif user.is_a?(Company)
      where("author_type = 'Admin' OR (author_type = 'BusinessIncubator' AND author_id = ?)", user.company_profile.business_incubator_profile.business_incubator_id)
    end
  }

  rails_admin do
    list do
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :image
      field :name
      field :code
      field :start_at
    end
    edit do
      field :image
      field :name
      field :code
      field :url
      field :start_at
    end
    show do
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :image
      field :name
      field :code
      field :url
      field :start_at
    end
  end

end
