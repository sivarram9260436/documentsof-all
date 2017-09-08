class Rating < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :entity , :polymorphic => true
end
