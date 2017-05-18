class CreateBusinessIncubatorProfiles < ActiveRecord::Migration
  def change
    create_table :business_incubator_profiles do |t|
      t.belongs_to :business_incubator, index: true
      t.string :name
      t.belongs_to :country, index: true
      t.belongs_to :region, index: true
      t.belongs_to :province, index: true
      t.belongs_to :city, index: true
      t.string :address
      t.string :zip_code
      t.string :phone
      t.string :fax
      t.string :web
      t.string :recipient_agency
      t.string :managing_agency
      t.string :contact_name
      t.integer :kind
      t.string :offices_count
      t.string :industrial_unit_count
      t.string :meeting_rooms_count
      t.string :training_rooms_count
      t.boolean :assembly_hall
      t.boolean :parking
      t.string :parking_count
      t.boolean :preincubation_zone
      t.boolean :video_surveillance
      t.boolean :electronic_access

      t.timestamps
    end
  end
end
