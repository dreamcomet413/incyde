class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :author_type
      t.integer :author_id
      t.string :name
      t.string :room
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
