class NotificationPlatform < ActiveRecord::Base

  belongs_to :author, polymorphic: true

  validates :recipient_ids, presence: true
  validates :author, presence: true
  validates :subject, presence: true
  validates :body, presence: true

  attr_accessor :recipient_ids

  after_create :send_notification

  def recipients
    users = if author.is_a?(Admin)
              User.find(recipient_ids)
            elsif author.is_a?(BusinessIncubator)
              author.companies.find(recipient_ids)
            else
              raise "Tipo de autor '#{self.class.name}' no controlado en NotificationPlatform"
            end
    users.map(&:mailboxer_email).join(",")
  end

  rails_admin do
    # weight -1 # Lleva esta opción de menú al principio
    list do
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :subject
      field :body
      field :created_at
    end

    edit do
      field :recipient_ids do
        partial "notification_platform/recipients"
      end
      field :subject
      field :body
    end

    show do
      field :author do
        visible do
          bindings[:controller].current_user.is_a? Admin
        end
      end
      field :subject
      field :body
      field :created_at
    end
  end

  private

  def send_notification
    Notifier.notification_platform(self, recipients).deliver
  end

end
