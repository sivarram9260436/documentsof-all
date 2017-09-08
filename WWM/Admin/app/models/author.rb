
class  Author < ActiveRecord::Base
 validate :author_validation
  #validates :firstname,:email, :presence => { :message => "should not be blank" }
  #validates :email, :uniqueness => {:case_sensitive => false}
  #validates :email, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}


  def author_validation
     errors[:base] << ("Site should not be blank") if self.site_ids.empty?
     errors[:base] << ("First Name should not be blank") if self.firstname.blank?
     errors[:base] << ("Email should not be blank") if self.email.blank?
     errors[:base] << ("Email has already been taken") if not Author.where("UPPER(email) = UPPER(?)", self.email.upcase.strip).blank? and  not self.email.blank? and self.new_record?
     errors[:base] << ("Email is invalid") if /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.match(self.email.strip.to_s).blank? and not self.email.blank?
  end

  
end
