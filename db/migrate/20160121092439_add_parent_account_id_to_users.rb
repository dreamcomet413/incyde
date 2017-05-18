class AddParentAccountIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parent_account_id, :integer
  end
end
