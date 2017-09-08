class Movie < ActiveRecord::Base
  #belongs_to :showtimes
  #has_many :theatres, through: :showtimes
  has_and_belongs_to_many :theatres

end