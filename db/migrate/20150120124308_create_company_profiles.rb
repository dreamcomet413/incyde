class CreateCompanyProfiles < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
      t.belongs_to :company, index: true
      t.belongs_to :business_incubator_profile, index: true
      t.belongs_to :sector, index: true
      t.string :name
      t.date :incorporation_date
      t.date :start_at
      t.date :end_at
      t.string :contact_name
      t.string :contact_surname
      t.string :contact_nif
      t.string :cnae
      t.integer :workers_number
      t.string :land_phone
      t.string :mobile_phone
      t.string :fax
      t.belongs_to :country, index: true
      t.belongs_to :region, index: true
      t.belongs_to :province, index: true
      t.belongs_to :city, index: true
      t.string :address
      t.string :zip_code
      t.string :activity
      t.string :web

      t.timestamps
    end
  end
end
