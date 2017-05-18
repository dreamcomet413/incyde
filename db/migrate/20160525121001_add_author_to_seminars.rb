class AddAuthorToSeminars < ActiveRecord::Migration
  def change
    add_reference :seminars, :author, polymorphic: true, index: true
  end
end
