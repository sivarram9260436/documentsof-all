class Theatre < ActiveRecord::Base
  #has_many :showtimes
  #has_many :movies, through: :showtimes
  has_and_belongs_to_many :movies
end