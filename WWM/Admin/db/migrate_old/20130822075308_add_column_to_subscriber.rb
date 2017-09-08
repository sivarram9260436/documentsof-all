class AddColumnToSubscriber < ActiveRecord::Migration
  def self.change
    add_column :subscribers , :business_email , :string
  end
end
