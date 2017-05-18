class CompanyProfile < ActiveRecord::Base

  belongs_to :company, inverse_of: :company_profile
  #belongs_to :business_incubator
  belongs_to :business_incubator_profile #, inverse_of: :company_profile
  belongs_to :sector
  belongs_to :country
  belongs_to :region
  belongs_to :province
  belongs_to :city

  # TODO ¿dejar esta validación o la de abajo?
  validates :business_incubator_profile_id, presence: true
  #validates :business_incubator_profile, presence: true

  # validates :name, presence: true
  # validates :legal_conditions, presence: true, on: :update
  # with_options on: :update do # TODO Ojo que tienen que reestablecer la contraseña
  #   validates :sector, presence: true
  #   validates :country, presence: true
  #   validates :region, presence: true
  #   validates :province, presence: true
  #   validates :city, presence: true
  # end


  def display_phones
    phones = [land_phone, mobile_phone]
    phones.compact.join " | "
  end

  rails_admin do
    visible false

    edit do
      #field :business_incubator
      #field :sector
      #field :email
      #field :company_profile
      #field "company_profile.name"
      #nested_form_for :company_profile do
      #  field :name
      #end
      #form_builder :nested_form_for #:company_profile
      #  field :name
      #end
      # field :name
      #field :business_incubator_profile
      field :business_incubator_profile_id, :hidden do
        default_value do
          bindings[:controller].current_user.business_incubator_profile.id if bindings[:controller].current_user.is_a? BusinessIncubator
        end
      end
      field :business_incubator_profile do
        inline_add false
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :sector do
        inline_add false
        inline_edit false

        # Elimina la limitación del select por defecto a 30
        associated_collection_scope do
          # bindings[:object] & bindings[:controller] are available, but not in scope's block!
          #team = bindings[:object]
          Proc.new { |scope|
            # scoping all Players currently, let's limit them to the team's league
            # Be sure to limit if there are a lot of Players and order them by position
            #scope = scope.where(league_id: team.league_id) if team.present?
            #scope = scope.limit(30) # 'order' does not work here
          }
        end

      end
      #field :sector do
      #  associated_collection_cache_all false
      #  associated_collection_scope do
      #    Proc.new { |scope|
      #      scope = scope.order("sectors.id DESC")
      #    }
      #  end
      #end
      field :incorporation_date
      field :start_at
      field :end_at
      field :start_at_in_business_incubator
      field :end_at_in_business_incubator
      field :contact_name
      field :contact_surname
      field :contact_nif
      field :cnae
      field :workers_number
      field :land_phone
      field :mobile_phone
      field :fax
      field :country
      field :region
      field :province
      field :city
      field :address
      field :zip_code
      field :activity
      field :web
      field :offer_description
      field :legal_conditions do
        help "<a href='/page/legal_conditions' target='_blank'>Ver condiciones</a>".html_safe
      end

    end
  end

end
