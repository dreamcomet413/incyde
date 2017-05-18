RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  #config.current_user_method(&:current_user)

  #config.authenticate_with do
  #   warden.authenticate! scope: :admin
  #end
  #config.current_user_method(&:current_admin)
  config.current_user_method(&:current_user)

  ## == Cancan ==
  #config.authorize_with :cancan
  config.authorize_with :cancan, AdminAbility

  config.excluded_models = ["Mailboxer::Conversation", "Mailboxer::Notification", "Mailboxer::Message",
                            "Mailboxer::Receipt", "Mailboxer::Conversation::OptOut", 'ArticleCategory', 'ContentLike']

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.browser_validations = false # Default is true
  config.compact_show_view = false

  config.actions do
    dashboard                     # mandatory
    index do
      # TODO Ver porque no funciona en producción el selector de viveros (create/edit) cuando se incluye 'BusinessIncubatorProfile'
      except ['CompanyProfile']
    end
    new do
      except ['CompanyProfile', 'BusinessIncubatorProfile']
    end
    export do
      only ["Company", "BusinessIncubator"]
    end
    bulk_delete do
      except ['NotificationPlatform', 'CompanyProfile', 'BusinessIncubatorProfile']
    end
    show
    edit do
      except ['NotificationPlatform', 'CompanyProfile', 'BusinessIncubatorProfile']
    end
    delete do
      except ['NotificationPlatform', 'CompanyProfile', 'BusinessIncubatorProfile']
    end
    #show_in_app

    # Add the nestable action for configured models
    nestable

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
