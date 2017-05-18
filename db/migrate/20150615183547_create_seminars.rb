class CreateSeminars < ActiveRecord::Migration
  def change
    create_table :seminars do |t|
      t.string :name
      t.string :url, limit: 1000
      t.datetime :start_at
      t.string :code

      t.timestamps
    end
  end
end
