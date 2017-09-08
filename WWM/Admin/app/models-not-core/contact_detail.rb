class ContactDetail < ActiveRecord::Base
   
  validates_format_of :phone_number, :with => /^\d{10}/, :message => "Give valid phone number"
  validates_format_of :email,:with=>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message=>"Give Valid Email id"
  validates_presence_of :email

 
end

