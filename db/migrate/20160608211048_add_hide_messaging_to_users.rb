class AddHideMessagingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hide_messaging, :boolean, default: false
  end
end
