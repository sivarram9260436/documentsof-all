class Showing < ActiveRecord::Base
  has_many :movies
  belongs_to :theatres
end
