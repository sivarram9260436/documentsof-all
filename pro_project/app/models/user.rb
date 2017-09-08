class User < ActiveRecord::Base
#
 validates :email, presence: true,:format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
#
#
# def full_name
#   "#{self.name} #{self.email}"
# end

end
