class BusinessIncubatorProfile < ActiveRecord::Base

  KIND_OPTIONS = {servicios: 1, industrial: 2, coworking: 3, mixto: 4}

  belongs_to :business_incubator, inverse_of: :business_incubator_profile
  has_many :company_profiles #, inverse_of: :business_incubator_profile
  has_many :companies, through: :company_profiles
  belongs_to :country
  belongs_to :region
  belongs_to :province
  belongs_to :city

  validates :country, presence: true
  validates :region, presence: true
  validates :province, presence: true
  validates :city, presence: true

  delegate :email, :name, to: :business_incubator, allow_nil: true


  def kind_options
    KIND_OPTIONS.map{|k,v| [I18n.t("business_incubator_profile.kind.#{k}"), v]}
  end

  def display_kind
    I18n.t("business_incubator_profile.kind.#{KIND_OPTIONS.key(kind)}") if KIND_OPTIONS.values.include?(kind)
  end

  rails_admin do
    visible false

    edit do
      field :country
      field :region
      field :province
      field :city
      field :address
      field :zip_code
      field :phone
      field :fax
      field :web
      field :recipient_agency
      field :managing_agency
      field :contact_name
      field :kind, :enum do
        enum_method do
          :kind_options
        end
      end
      field :offices_count
      field :industrial_unit_count
      field :meeting_rooms_count
      field :training_rooms_count
      field :assembly_hall
      field :parking
      field :parking_count
      field :preincubation_zone
      field :video_surveillance
      field :electronic_access
      field :facebook_url
      field :twitter_url
    end
    show do
      field :business_incubator
      field :country
      field :region
      field :province
      field :city
      field :address
      field :zip_code
      field :phone
      field :fax
      field :web
      field :recipient_agency
      field :managing_agency
      field :contact_name
      field :display_kind
      field :offices_count
      field :industrial_unit_count
      field :meeting_rooms_count
      field :training_rooms_count
      field :assembly_hall
      field :parking
      field :parking_count
      field :preincubation_zone
      field :video_surveillance
      field :electronic_access
      field :facebook_url
      field :twitter_url
    end
  end

end
