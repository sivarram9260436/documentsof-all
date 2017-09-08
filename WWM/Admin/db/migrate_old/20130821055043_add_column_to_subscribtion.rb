class AddColumnToSubscribtion < ActiveRecord::Migration
  def self.change
   add_column :subscriptions,:status,:string
  end
end
