class AdminAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    # Común a todos los usuarios
    cannot :export, :all
    # TODO verificar porque no funciona esto
    # can [:regions, :provinces, :cities], :city_selects
    # can :manage, :city_selects

    # Para que no puedan crear estas entidades en nombre de otro, asigna estos valores
    if user && (user.is_a?(Admin) || user.is_a?(BusinessIncubator))
      [Article, Conference, NotificationPlatform, Seminar].each do |model|
        can :create, model, author_type: user.class.name, author_id: user.id
      end
    end

    #user ||= User.new # guest user (not logged in)
    #if user.admin?

    # Perfil de usuario público / sin logar
    if user.nil?
      cannot :index, Article

    # Perfil de Admin / Fundación Incyde
    elsif user.is_a?(Admin)
      can :manage, :all
      cannot :export, :all
      can :export, Company
      can :export, BusinessIncubator

    # Perfil de Vivero / Gestor de vivero
    elsif user.is_a?(BusinessIncubator)
      can :access, :rails_admin # needed to access RailsAdmin

      # Performed checks for `root` level actions:
      can :dashboard            # dashboard access

      # Performed checks for `collection` scoped actions:
      #can :index, Article, author_type: user.class.name, author_id: user.id         # included in :read
      #can :read, Article #, author_type: user.class.name, author_id: user.id         # included in :read
      #can :index, Article
      can :manage, Article, author_type: user.class.name, author_id: user.id
      cannot :export, Article
      can :read, ArticleCategory

      can :manage, Conference, author_type: user.class.name, author_id: user.id
      can :manage, NotificationPlatform, author_type: user.class.name, author_id: user.id
      can :manage, Seminar, author_type: user.class.name, author_id: user.id
      #can :index, Article, author_type: user.class.name, author_id: user.id
      ##can :read, Article.visible_for(user)
      #can :new, Article, author_type: user.class.name, author_id: user.id
      #can :edit, Article, author_type: user.class.name, author_id: user.id

      #can :read, Company
      #can :manage, User
      can :read, Sector
      can :read, [Country, Region, Province, City]

      #can :manage, BusinessIncubatorProfile, business_incubator_id: user.id
      can :index, BusinessIncubatorProfile, business_incubator_id: user.id
      #can :manage, CompanyProfile, business_incubator_profile: user.business_incubator_profile
      #can :create, CompanyProfile, business_incubator_profile_id: user.business_incubator_profile.id
      #can :manage, CompanyProfile, business_incubator_profile_id: user.business_incubator_profile.id
      #can :manage, CompanyProfile, business_incubator: user
      #can :create, Company, company_profile: {business_incubator_profile_id: user.business_incubator_profile.id}
      #can :create, Company, company_profile_attributes: {business_incubator_profile_id: user.business_incubator_profile.id}
      #can :manage, Company, company_profile: {business_incubator_profile: user.business_incubator_profile}
      can :manage, Company, company_profile: {business_incubator_profile_id: user.business_incubator_profile.id}
      #can :read, Company.by_business_incubator(user)
      #can :manage, Company, "company_profiles.business_incubator_id" => user.business_incubator_profile.id
      #can :edit, Company, business_incubator: user.business_incubator

      #can :export, Model
      #can :history, Model       # for HistoryIndex
      #can :destroy, Model       # for BulkDelete
      #
      ## Performed checks for `member` scoped actions:
      #can :show, Model, object            # included in :read
      #can :edit, Article, user.articles do |article| # included in :update
      #  article
      #end
      #can :destroy, Model, object         # for Delete
      #can :history, Model, object         # for HistoryShow
      #can :show_in_app, Model, object

    # Perfil de Viverista
    elsif user.is_a?(Company)
      # Sin acceso a la admin, no puede hacer nada aquí
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
