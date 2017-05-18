#class Company < ActiveRecord::Base
class Company < User


  #belongs_to :business_incubator
  #belongs_to :sector
  #belongs_to :country
  #belongs_to :region
  #belongs_to :province
  #belongs_to :city
  has_one :company_profile, dependent: :destroy
  alias_method :profile, :company_profile

  validates :company_profile, presence: true
  #validates :business_incubator, presence: true
  #validates :sector, presence: true
  #validates :name, presence: true
  #validates :country, presence: true
  #validates :province, presence: true
  #validates :city, presence: true

  after_create :send_welcome

  delegate :sector, :city, :land_phone, :mobile_phone, :display_phones, :address, :zip_code,
           :activity, :web, :offer_description,
           to: :company_profile, allow_nil: true

  accepts_nested_attributes_for :company_profile

  ## Include default devise modules. Others available are:
  ## :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable
  #
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" } #, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #scope :by_business_incubator, -> (business_incubator) {where(business_incubator_id: business_incubator.id)}
  scope :by_business_incubator, -> (business_incubator) {includes(:company_profile).where("company_profiles.business_incubator_profile_id" => business_incubator.business_incubator_profile.id)}
  scope :search, -> (params_search) {
    result = joins(:company_profile)
    unless params_search[:query].blank?
      result = result.where("#{table_name}.name like ?", "%#{params_search[:query]}%")
    end
    unless params_search[:sector].blank?
      result = result.where("company_profiles.sector_id" => params_search[:sector])
    end
    unless params_search[:province].blank?
      result = result.where("company_profiles.province_id" => params_search[:province])
    end
    result
  }

  before_update :set_deactivated_at, if: "company_profile.end_at_in_business_incubator_changed?"

  def set_deactivated_at
    self.deactivated_at = company_profile.end_at_in_business_incubator
  end

  def profile_class
    :company_profile
  end

  rails_admin do
    navigation_label ADMIN_MENU_USERS
    list do
      field :email
      field :name
      # field "Nombre" do pretty_value { bindings[:object].company_profile.name } end
      field "Vivero" do pretty_value { bindings[:object].company_profile.business_incubator_profile.name } end
      field "Contacto en vivero" do pretty_value { bindings[:object].company_profile.business_incubator_profile.email } end
    end
    edit do
      #field :business_incubator
      #field :sector
      field :name
      field :email
      field :password do
        visible do
          !bindings[:object].new_record?
        end
      end
      field :password_confirmation do
        visible do
          !bindings[:object].new_record?
        end
      end
      field :avatar
      field :company_profile do
        active true
      end
      #group :company_profile do
      #  #active false
      #  field :name
      #end
      #field "company_profile.name"

      #configure :company_profile do
      #  partial 'tech_specs_field'
      #  #field :name
      #end

      #nested_form_for :company_profile do
      #  field :name
      #end
      #form_builder :nested_form_for #:company_profile
      #  field :name
      #end
      #field :name
      #field :incorporation_date
      #field :start_at
      #field :end_at
      #field :contact_name
      #field :contact_surname
      #field :contact_nif
      #field :cnae
      #field :workers_number
      #field :land_phone
      #field :mobile_phone
      #field :fax
      #field :country
      #field :region
      #field :province
      #field :city
      #field :address
      #field :zip_code
      #field :activity
      #field :web
    end

    show do
      field :email
      field :avatar
      field :company_profile
    end

    export do
      field :email
      field "Nombre" do pretty_value { bindings[:object].company_profile.try(:name) } end
      field "Vivero" do pretty_value { bindings[:object].company_profile.business_incubator_profile.try(:name) } end
      field :sector do pretty_value { bindings[:object].company_profile.sector.try(:name) } end

      [
          :incorporation_date,
          :start_at,
          :end_at,
          :contact_name,
          :contact_surname,
          :contact_nif,
          :cnae,
          :workers_number,
          :land_phone,
          :mobile_phone,
          :fax,
          #:country,
          #:region,
          #:province,
          #:city,
          :address,
          :zip_code,
          :activity,
          :web,
      ].each do |f|
        field I18n.t(f, scope: "activerecord.attributes.company_profile") do pretty_value { bindings[:object].company_profile.send(f) } end
      end
      [
          :country,
          :region,
          :province,
          :city,
      ].each do |f|
        field I18n.t(f, scope: "activerecord.attributes.company_profile") do pretty_value { bindings[:object].company_profile.send(f).try(:name) } end
      end

      #field I18n.t("incorporation_date", scope: "activerecord.attributes.company_profile") do pretty_value { bindings[:object].company_profile.incorporation_date } end
      #field :start_at do pretty_value { bindings[:object].company_profile.start_at } end
      #field :end_at do pretty_value { bindings[:object].company_profile.end_at } end
      #field :contact_name do pretty_value { bindings[:object].company_profile.contact_name } end
      #field :contact_surname do pretty_value { bindings[:object].company_profile.contact_surname } end
      #field :contact_nif do pretty_value { bindings[:object].company_profile.contact_nif } end
      #field :cnae do pretty_value { bindings[:object].company_profile.cnae } end
      #field :workers_number do pretty_value { bindings[:object].company_profile.workers_number } end
      #field :land_phone do pretty_value { bindings[:object].company_profile.land_phone } end
      #field :mobile_phone do pretty_value { bindings[:object].company_profile.mobile_phone } end
      #field :fax do pretty_value { bindings[:object].company_profile.fax } end
      #field :country do pretty_value { bindings[:object].company_profile.country.try(:name) } end
      #field :region do pretty_value { bindings[:object].company_profile.region.try(:name) } end
      #field :province do pretty_value { bindings[:object].company_profile.province.try(:name) } end
      #field :city do pretty_value { bindings[:object].company_profile.city.try(:name) } end
      #field :address do pretty_value { bindings[:object].company_profile.address } end
      #field :zip_code do pretty_value { bindings[:object].company_profile.zip_code } end
      #field :activity do pretty_value { bindings[:object].company_profile.activity } end
      #field :web do pretty_value { bindings[:object].company_profile.web } end
    end

  end

  # Importador manual para ejecutar desde la consola
  # Debe llevar header y respetar los nombres que damos acontinuación
  # Debe de ser al menos el siguiente: 'email', 'company_name',
  # También puede llevar estas columnas 'space', 'name', 'surname', 'name_and_surname'
  def self.csv_import(path_file, business_incubator_profile)
    CSV.foreach(path_file, headers: true) do |row|
      p row.to_hash
      contact_name = row['name']
      contact_surname = row['surname']
      if row['name_and_surname'].present?
        contact_name = row['name_and_surname'].split(" ").first
        contact_surname = row['name_and_surname'].split(" ")[1..-1].join(" ")
      end

      a = Company.create(email: row['email'],
                      company_profile_attributes:{
                          name: row['company_name'],
                          space: row['space'],
                          contact_name: contact_name,
                          contact_surname: contact_surname,
                          business_incubator_profile: business_incubator_profile
                      })
      unless a.valid?
        p "*"*200
        p "***** ERROR ****** No se pudo crear => #{row.to_hash}"
        p a.errors.entries
        p "*"*200
      end
    end
  end

  private

  def send_welcome
    token = self.set_reset_password_token_with_devise!
    Notifier.company_welcome(self, token).deliver
  end




end
