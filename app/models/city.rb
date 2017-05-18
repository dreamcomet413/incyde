class City < ActiveRecord::Base

  belongs_to :province
  has_many :business_incubator_profiles
  has_many :business_incubators, through: :business_incubator_profiles

  has_many :company_profiles

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :province, presence: true

  scope :by_province, -> (province_id) { where(province_id: province_id) }
  scope :ordered, -> { order('name asc') }

  rails_admin do
    navigation_label ADMIN_MENU_AUX
    visible do
      # controller bindings is available here. Example:
      bindings[:controller].current_user.is_a? Admin
    end
    list do
      field :name
      field :province
    end
    edit do
      field :name
      field :province
    end
    show do
      field :name
      field :province
    end
  end

end
