class AddColumnToShowing < ActiveRecord::Migration
  def change
    add_column :showings, :movie_id, :integer
    add_column :showings, :theatre_id, :integer
  end
end