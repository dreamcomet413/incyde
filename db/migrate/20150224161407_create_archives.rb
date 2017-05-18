class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :user_id
      t.string :user_type

      t.timestamps
    end
  end
end
