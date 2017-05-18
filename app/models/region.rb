class Region < ActiveRecord::Base

  belongs_to :country
  has_many :provinces

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :country, presence: true

  scope :by_country, -> (country_id) { where(country_id: country_id) }
  scope :ordered, -> { order('name asc') }

  rails_admin do
    navigation_label ADMIN_MENU_AUX
    visible do
      # controller bindings is available here. Example:
      bindings[:controller].current_user.is_a? Admin
    end
    list do
      field :name
      field :country
    end
    edit do
      field :name
      field :country
    end
    show do
      field :name
      field :country
    end
  end

end
