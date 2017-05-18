class AddAuthorToNotificationPlatforms < ActiveRecord::Migration
  def change
    add_reference :notification_platforms, :author, polymorphic: true, index: true
  end
end
