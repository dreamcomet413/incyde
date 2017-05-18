class AddSpaceToCompanyProfiles < ActiveRecord::Migration
  def change
    add_column :company_profiles, :space, :string
  end
end
