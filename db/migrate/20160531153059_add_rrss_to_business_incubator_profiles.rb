class AddRrssToBusinessIncubatorProfiles < ActiveRecord::Migration
  def change
    add_column :business_incubator_profiles, :facebook_url, :string, limit: 1000
    add_column :business_incubator_profiles, :twitter_url, :string, limit: 1000
  end
end
