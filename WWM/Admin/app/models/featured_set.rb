class FeaturedSet < ActiveRecord::Base
 
  has_many :featured_digital_assets,:dependent=>:destroy
  has_many :digital_assets,:through=>:featured_digital_assets,:source_type=>"DigitalAsset",:source=>:entity,:order=>"sequence_number asc"
  def digital_asset_ids=(digital_asset_ids)
    self.featured_digital_assets.destroy_all
    unless digital_asset_ids.blank?
      all_digital_asset_ids = digital_asset_ids.delete_if{|id| id.blank? }
      all_digital_asset_ids = all_digital_asset_ids.slice(0..29)           # why we are taking only first 30 elements from array
      all_digital_asset_ids.each_with_index do |digital_asset_id, i|
        featured_digital_asset = self.get_featured_digital_asset(digital_asset_id)
        featured_digital_asset.update_attributes( :sequence_number => i, :entity_type => "DigitalAsset", :entity_id => digital_asset_id )
        featured_digital_asset.save
      end
    end
  end

  def get_featured_digital_asset(digital_asset_id)
    self.featured_digital_assets.find_by_entity_id(digital_asset_id) || self.featured_digital_assets.new
  end
 
 
 
   def self.article_search(search)
     if search 
        FeaturedSet.where("LOWER(name) LIKE ? and model_name = ?", "%#{search.downcase.strip}%", "Article")
     else
  	FeaturedSet.where(:model_name => "Article")
     end
   end
 
   def self.digital_search(search)
      if search
 	 FeaturedSet.where("LOWER(name) LIKE ? and model_name = ?", "%#{search.downcase.strip}%", "Digital_asset")
       else
   	 FeaturedSet.where(:model_name => "Digital_asset")
      end
  end 

end

