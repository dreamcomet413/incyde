class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #

    # Común a todos los usaurios
    can :read, :home_controller # Todos los perfiles pueden acceder a la home
    can [:index, :read], BusinessIncubator # Todos los perfiles pueden acceder a la home
    can :toggle_like, Article # Todos los perfiles pueden hacer like en noticias
    can [:autocomplete_sector_name, :autocomplete_province_name], Company

    #user ||= User.new # guest user (not logged in)
    #if user.admin?

    # Perfil de usuario público / sin logar
    if user.nil?
      cannot :index, Article

    # Perfil de Admin / Fundación Incyde
    elsif user.is_a?(Admin)
      can :manage, :all

    # Perfil de Vivero / Gestor de vivero
    elsif user.is_a?(BusinessIncubator)
      can :manage, :profile
      can :manage, :switch_user

      # Performed checks for `collection` scoped actions:
      can :index, Article
      can :read, Article.visible_for(user)
      can :read, Company

      can :manage, Mailboxer::Conversation
      can [:index, :read], Conference
      can [:index], Seminar

      can :access, :rails_admin # Para que aparezca el enlace, los permisos de la admin están en AdminAbility

    # Perfil de Viverista
    elsif user.is_a?(Company)
      can :manage, :profile

      can :index, Article
      can :read, Article.visible_for(user)

      can :read, Company
      can :manage, Mailboxer::Conversation
      can [:index, :read], Conference
      can [:index], Seminar
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
