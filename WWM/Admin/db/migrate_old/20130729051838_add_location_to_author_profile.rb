class AddLocationToAuthorProfile < ActiveRecord::Migration
  def change
    add_column :author_profiles, :location, :string
  end
end
