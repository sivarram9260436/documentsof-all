class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      add_column :showings, :movie_id, :integer
      add_column :showings, :theatre_id, :integer

      t.timestamps
    end
  end
end
