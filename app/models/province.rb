class Province < ActiveRecord::Base

  belongs_to :region
  has_many :cities
  has_many :business_incubator_profiles
  has_many :business_incubators, through: :business_incubator_profiles
  has_many :company_profiles
  has_many :companies, through: :company_profiles

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :region, presence: true

  scope :by_region, -> (region_id) { where(region_id: region_id) }
  scope :ordered, -> { order('name asc') }

  rails_admin do
    navigation_label ADMIN_MENU_AUX
    visible do
      # controller bindings is available here. Example:
      bindings[:controller].current_user.is_a? Admin
    end
    list do
      field :name
      field :region
    end
    edit do
      field :name
      field :region
    end
    show do
      field :name
      field :region
    end
  end

end
