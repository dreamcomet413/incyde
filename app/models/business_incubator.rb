class BusinessIncubator < User


  has_many :articles, as: :author
  has_one :business_incubator_profile, inverse_of: :business_incubator, dependent: :destroy
  alias_method :profile, :business_incubator_profile
  has_many :companies, through: :business_incubator_profile
  has_many :archives, as: :user #, :inverse_of => :user
  # Un vivero podrá gestionar varios viveros asociados ('accounts' / 'parent_account')
  has_many :accounts, class_name: BusinessIncubator, foreign_key: 'parent_account_id'
  belongs_to :parent_account, class_name: BusinessIncubator, foreign_key: 'parent_account_id'

  delegate :address, :phone, :web, :province, :city, :zip_code, to: :business_incubator_profile, allow_nil: true

  validates :business_incubator_profile, presence: true

  after_create :send_welcome

  scope :ordered, -> {order("#{table_name}.position_business_incubator asc")}
  scope :index_view, -> {includes(business_incubator_profile: :city)}

  accepts_nested_attributes_for :business_incubator_profile
  accepts_nested_attributes_for :archives, :allow_destroy => true

  def mailboxer_email(object = nil)
    master_account.email
  end

  def profile_class
    :business_incubator_profile
  end

  def multi_account?
    accounts.present? || !parent_account_id.nil?
  end

  def master_account?
    parent_account_id.nil? && accounts.present?
  end

  def managed_account?
    !parent_account_id.nil?
  end

  def master_account
    parent_account.nil? ? self : parent_account
  end

  def accounts_to_manage
    ids = if master_account?
            # accounts
            accounts + [self.id]
          elsif parent_account.present?
            # ids = [parent_account.id] + [parent_account.accounts.where.not(id: self.id).ids]
            [parent_account.id] + [parent_account.accounts.ids]
          else
            []
          end
    BusinessIncubator.where(id: ids)
  end


  rails_admin do
    nestable_list({
      position_field: :position_business_incubator
    })
    navigation_label ADMIN_MENU_USERS
    list do
      field :avatar
      field :name
      field :email
    end
    edit do
      field :parent_account do
        help 'Opcional - Seleccionar el vivero que hará de gestor sólo cuando sea necesario'
      end
      field :name
      field :email
      field :password  do
        visible do
          !bindings[:object].new_record?
        end
      end
      field :password_confirmation  do
        visible do
          !bindings[:object].new_record?
        end
      end
      field :avatar
      field :business_incubator_profile do
        active true
      end
      field :archives do
        active true
      end
    end
    show do
      field :name
      field :email
      field :avatar
      field :business_incubator_profile
      field :archives
    end
    export do
      i18n_scope_str = "activerecord.attributes.business_incubator_profile"
      field :email
      #field "Nombre" do pretty_value { bindings[:object].company_profile.try(:name) } end
      #field "Vivero" do pretty_value { bindings[:object].company_profile.business_incubator_profile.try(:name) } end
      #field :sector do pretty_value { bindings[:object].company_profile.sector.try(:name) } end

      [
           :name,
           #:country,
           #:region,
           #:province,
           #:city,
           :address,
           :zip_code,
           :phone,
           :fax,
           :web,
           :recipient_agency,
           :managing_agency,
           :contact_name,
           #:kind,
           :offices_count,
           :industrial_unit_count,
           :meeting_rooms_count,
           :training_rooms_count
           #:assembly_hall,
           #:parking,
           #:parking_count,
           #:preincubation_zone,
           #:video_surveillance,
           #:electronic_access,
      ].each do |f|
        field I18n.t(f, scope: i18n_scope_str) do pretty_value { bindings[:object].business_incubator_profile.send(f) } end
      end
      field I18n.t(:kind, scope: i18n_scope_str) do pretty_value { bindings[:object].business_incubator_profile.display_kind } end
      [
          :assembly_hall,
          :preincubation_zone,
          :video_surveillance,
          :electronic_access,
          :parking
      ].each do |f|
        field I18n.t(f, scope: i18n_scope_str) do pretty_value { bindings[:object].business_incubator_profile.send(f) ? "Si" : "No" } end
      end
      field I18n.t(:parking_count, scope: i18n_scope_str) do pretty_value { bindings[:object].business_incubator_profile.parking_count } end
      [
          :country,
          :region,
          :province,
          :city
      ].each do |f|
        field I18n.t(f, scope: i18n_scope_str) do pretty_value { bindings[:object].business_incubator_profile.send(f).try(:name) } end
      end
    end
  end

  private

  def send_welcome
    token = self.set_reset_password_token_with_devise!
    Notifier.business_incubator_welcome(self, token).deliver
  end



end
