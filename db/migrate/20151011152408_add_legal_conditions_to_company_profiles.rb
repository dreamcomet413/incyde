class AddLegalConditionsToCompanyProfiles < ActiveRecord::Migration
  def change
    add_column :company_profiles, :legal_conditions, :boolean, default: true
  end
end
