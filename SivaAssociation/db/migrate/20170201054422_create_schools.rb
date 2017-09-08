class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :text

      t.timestamps
    end
  end
end
