class AddFieldsToCompanyProfiles < ActiveRecord::Migration
  def change
    add_column :company_profiles, :start_at_in_business_incubator, :datetime
    add_column :company_profiles, :end_at_in_business_incubator, :datetime
    add_column :company_profiles, :offer_description, :text
  end
end
