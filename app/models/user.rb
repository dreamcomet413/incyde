class User < ActiveRecord::Base

  has_many :content_likes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_attached_file :avatar, :styles => { :medium => "400x400>", :thumb => "100x100>" }, :default_url => "placeholder-avatar.png" #, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_validation :set_default_password

  scope :active, -> {where("deactivated_at is NULL OR deactivated_at > ?", Time.now)}
  scope :no_hidden_messaging, -> {where(hide_messaging: false)}

  acts_as_messageable

  #def password_required?
  #  self.new_record? ? false : !persisted? || !password.nil? || !password_confirmation.nil?
  #end

  def mailboxer_name
    name
  end

  def mailboxer_email(object = nil)
    email
  end

  def multi_account?
    false
  end

  def set_reset_password_token_with_devise!
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    self.save(validate: false)
    raw
  end

  def like?(content)
    content_likes.find_by(likeable: content).present?
  end

  rails_admin do
    visible false
    list do
      field :email
    end
  end

  def deactivated?
    !deactivated_at.nil? && deactivated_at < Time.now
  end

  # Devise - ensure user account is active
  def active_for_authentication?
    super && !deactivated?
  end

  private

  def set_default_password
    if self.new_record?
      pwd = SecureRandom.hex 6
      self.password = pwd
      self.password_confirmation = pwd
    end
  end

end
