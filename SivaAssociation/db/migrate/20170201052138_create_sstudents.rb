class CreateSstudents < ActiveRecord::Migration
  def change
    create_table :sstudents do |t|
      t.string :name
      t.integer :roll_no

      t.timestamps
    end
  end
end
