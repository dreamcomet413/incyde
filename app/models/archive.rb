class Archive < ActiveRecord::Base

  belongs_to :user, polymorphic: true #, :inverse_of => :archives

  has_attached_file :upload, :styles => { :medium => "900x900>", :thumb => "150x150>" } #, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/

  #include Rails.application.routes.url_helpers


  #rails_admin do
  #  configure :user do
  #    # configuration here
  #    active true
  #  end
  #end


  rails_admin do
    visible false

    edit do
      field :user_type, :hidden do
        default_value do
          User.find(@bindings[:view].params[:id]).class.name
        end
      end
      field :user_id, :hidden do
        default_value do
          @bindings[:view].params[:id]
        end
      end
      field :upload
    end

  #  edit do
  #    field :user, :hidden do
  #      default_value do
  #        bindings[:controller].current_user.business_incubator_profile.id if bindings[:controller].current_user.is_a? BusinessIncubator
  #      end
  #    end
  #    #field :user_id, :hidden do
  #    #  default_value do
  #    #    bindings[:controller].current_user.business_incubator_profile.id if bindings[:controller].current_user.is_a? BusinessIncubator
  #    #  end
  #    #end
  #    #field :user_type do
  #    #  visible do
  #    #    bindings[:controller].current_user.is_a? Admin
  #    #  end
  #    #end
  #  end
  #
  end

end
