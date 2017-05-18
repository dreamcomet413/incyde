class Sector < ActiveRecord::Base

  has_many :company_profiles

  validates :name, presence: true
  validates :name, uniqueness: true

  rails_admin do
    navigation_label ADMIN_MENU_AUX
    visible do
      # controller bindings is available here. Example:
      bindings[:controller].current_user.is_a? Admin
    end
    list do
      field :name
    end
    edit do
      field :name
    end
    show do
      field :name
    end
  end

end
