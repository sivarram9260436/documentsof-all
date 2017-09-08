class MagazineIssue < ActiveRecord::Base

  has_one :digital_asset ,:as=>:entity ,:dependent=>:destroy,:class_name=>"DigitalAssetProperty"
  
  scope :date_of_publications,  :order=>'magazine_issues.date_of_publication asc' 

  scope :by_year, lambda {|year,source_id|
    {:conditions=>[" magazine_issues.date_of_publication between ? and ? and magazine_issues.source_id = ?",Time.utc(year),Time.utc(year.next),source_id]}
  }

  scope :by_month_year, lambda {|value|
    {:conditions=>[" magazine_issues.date_of_publication between ? and ?",Time.local(value.split('-')[0],value.split('-')[1]).beginning_of_month, Time.local(value.split('-')[0],value.split('-')[1]).end_of_month]}}


  #added by gurudath to save the digital_assets
  def digital_asset_file=(asset)
    self.digital_asset.delete unless self.digital_asset.blank?
    self.digital_asset=DigitalAssetProperty.create(:entity_id => self.id,:entity_type => "MagazineIssue",:digital_asset_id=>asset) unless asset.blank? 
  end

end
