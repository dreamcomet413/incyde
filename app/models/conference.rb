class Conference < ActiveRecord::Base

  belongs_to :author, polymorphic: true

  validates :author, presence: true
  validates :name, presence: true

  has_attached_file :image, :styles => { :medium => "360x240>" } #, :default_url => "placeholder-image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :active, -> {where("start_at <= :now AND (end_at >= :now OR end_at is null)", now: Time.now)} # TODO revisar que en produción se actializa en now y no se cachea
  scope :visible_for, -> (user){
    if user.is_a?(Admin)
      all
    elsif user.is_a?(BusinessIncubator)
      where("author_type = 'Admin' OR (author_type = 'BusinessIncubator' AND author_id = ?)", user.id)
    elsif user.is_a?(Company)
      where("author_type = 'Admin' OR (author_type = 'BusinessIncubator' AND author_id = ?)", user.company_profile.business_incubator_profile.business_incubator_id)
    end
  }

  after_validation :set_room

  def url
    "https://appear.in/#{room}"
  end

  def display_date(field)
    date = self.send(field)
    if [:start_at, :end_at].include?(field)
      I18n.l(date.to_date) if date
    end
  end


  private

  def set_room
    self.room = "incyde-#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}-#{name.downcase.parameterize}"
  end

  rails_admin do
    list do
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :image
      field :name
      field :room
      field :start_at
      field :end_at
    end
    edit do
      field :image
      field :name
      field :start_at
      field :end_at
    end
    show do
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :image
      field :name
      field :room
      field :start_at
      field :end_at
    end
  end

end
