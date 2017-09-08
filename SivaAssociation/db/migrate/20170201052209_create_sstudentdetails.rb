class CreateSstudentdetails < ActiveRecord::Migration
  def change
    create_table :sstudentdetails do |t|
      t.string :address
      t.string :father_name
      t.integer :sstudent_id
      t.timestamps
    end
  end
end
