class CreateNotificationPlatforms < ActiveRecord::Migration
  def change
    create_table :notification_platforms do |t|
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
