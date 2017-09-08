class AddSstudentIdToSstudentDetail < ActiveRecord::Migration
  def change
    add_column :sstudents, :sstudent_id, :integer

  end
end
