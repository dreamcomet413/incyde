class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name
      t.belongs_to :region, index: true

      t.timestamps
    end
  end
end
