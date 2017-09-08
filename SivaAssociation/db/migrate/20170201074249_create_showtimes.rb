class AddColumnToShowtime < ActiveRecord::Migration
  def change
    add_column :showtimes, :movie_id, :integer
    add_column :showtimes, :theatre_id, :integer
  end
end