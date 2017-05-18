#class Admin < ActiveRecord::Base
class Admin < User


  has_many :articles, as: :author
  has_many :conferences, as: :author

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" } #, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  # Atributo o texto a mostrar en el caso del Admin
  # def name
  #   email
  # end


  rails_admin do

    navigation_label ADMIN_MENU_USERS # Ver https://github.com/sferik/rails_admin/wiki/Navigation
    label "Administrador"
    label_plural "Administradores"

    list do
      field :email
      field :name
      field :created_at
    end
    edit do
      field :name
      field :email
      field :password
      field :password_confirmation
      field :avatar
      field :hide_messaging
    end
    show do
      field :name
      field :email
    end
  end

  private

  def set_default_password
    # No establecemos la pwd en este rol, dejamos que la puedan meter en el formulario
  end

end
