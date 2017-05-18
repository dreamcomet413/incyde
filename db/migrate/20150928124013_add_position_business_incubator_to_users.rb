class AddPositionBusinessIncubatorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :position_business_incubator, :integer
  end
end
