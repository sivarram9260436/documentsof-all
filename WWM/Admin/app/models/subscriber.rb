class Subscriber < ActiveRecord::Base
  has_and_belongs_to_many :newsletters
  
  validate :subscriber_validation
  
scope :by_phone, lambda {|phone| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(phone) LIKE UPPER(?))',"%%"+phone+"%%"] }} 
scope :by_address1, lambda {|address1| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(address1) LIKE UPPER(?))',"%%"+address1+"%%"] }} 
scope :by_city, lambda {|city| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(city) LIKE UPPER(?))',"%%"+city+"%%"] }} 
scope :by_country_id, lambda {|country_id| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where country_id in (?))',country_id] }} 
scope :by_postal_code, lambda {|postal_code| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(postal_code) LIKE UPPER(?))',"%%"+postal_code+"%%"] }} 
scope :by_county_name, lambda {|county_name| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(county_name) LIKE UPPER(?))',"%%"+county_name+"%%"] }} 
scope :by_id,lambda {|id| {:conditions=>['moderator_status = ?', id]}}
scope :by_new_user_date_range, lambda{|from, to| { :conditions => ['created_at between ? and ?', from, to],:order=>'created_at DESC' } }
scope :by_start_date,lambda {|start_date| {:conditions=>['subscribers.created_at >= ?', (start_date || Time.zone.now - 10.years)]}}
scope :by_end_date,lambda {|end_date| {:conditions=>['subscribers.created_at <= ?', (end_date || Time.zone.now)]}}  
  scope :by_end_user_company_name, lambda {|end_user_company_name| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(end_user_company_name) LIKE UPPER(?))',"%%"+end_user_company_name+"%%"] }} 
scope :by_Job_title, lambda {|job_title| {:conditions => 
      ['subscribers.id in (select subscriber_id from subscriber_properties where UPPER(Job_title) LIKE UPPER(?))',"%%"+job_title+"%%"] }} 
  
  def subscriber_validation
    errors[:base] << ("1_FirstName should not be blank") if self.first_name.blank?
    errors[:base] << ("2_LastName should not be blank") if self.last_name.blank?
    errors[:base] << ("3_Email should not be blank") if self.email_id.blank?
  end
  
  
def self.advanced_search_subscriber(search={}, page=nil, per_page=nil,paginate=true)
    method_mappings = {:first_name => :by_firstname,:last_name => :by_lastname,:email_id => :by_email,:end_user_company_name=>:by_end_user_company_name,
                       :Job_title=>:by_Job_title,:start_date=>:by_start_date,:end_date=>:by_end_date}
    results = Subscriber.only_subscriber
    search.each do |key,value|
      if !value.blank? and value!=''
        method_name=method_mappings[key.to_sym]
         if key == 'id'
           results= results.scoped(:conditions =>["subscribers.#{key}=?",value ]) if not value.blank?
         else
           results=results.send(method_name, value) if not value.blank?
         end
      end
    end
    return (paginate == true ? results.paginate(:page=>page,:per_page=>per_page) : results)
  end  
  
  
  def reset_password(pass,conf_pass)
    status=true    
logger.info "p--------------------------------------------------#{pass}"
logger.info "p--------------------------------------------------#{conf_pass}"
    if pass!=conf_pass      
       errors[:base] << ("Password and confirm password don't match.")
      status=false   
    elsif pass==""  
      errors[:base] << ("Password should not be blank")
      status=false
    elsif conf_pass==""
      errors[:base] << ("Confirm Password should not be blank")
      status=false
    elsif pass.length < 5
      errors[:base] << ("Password should not be less than 5 characters")
      status=false  
    else
      password_encryption(pass)
      self.save(:validate=>false)
  #    self.errors.add("Successfully Saved")     
    end
    return self,status
  end

  def password_encryption(pass)  
    self.password=Digest::MD5.hexdigest(pass) if pass
  end

end
