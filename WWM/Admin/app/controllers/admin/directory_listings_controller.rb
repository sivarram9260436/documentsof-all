class Admin::DirectoryListingsController < AdminController
  

  def new
    @page_properties={:selected_menu=>'directory_listing_menu',:menu_title=>'Directory Listing > Create New Directory Listing'}                
    @directory_listing=DirectoryListing.new()
    @directory_listing_sponsors=DirectorySponsor.find(:all)
    render :action => 'new'
  end
  
 def create
    @page_properties={:selected_menu=>'directory_listing_menu',:menu_title=>'New Directory Listing'}   
    @directory_listing=DirectoryListing.new(params[:directory_listing])
    if params[:image_property] and params[:image_property][:image_id]!=""      
        @image_property=ImageProperty.new(params[:image_property]) 
        @directory_listing.image=@image_property 
    end 
    number_of_primary_selected=[]
    if params[:directory_listing] and not params[:directory_listing][:new_contact_details].blank?
    params[:directory_listing][:new_contact_details].each{|keys| keys.each{|key,value| number_of_primary_selected << value if key=="primary" and value=="1"}}
    Ambient.number_of_primary_selected = number_of_primary_selected
   end
    if params[:directory_image] and params[:directory_image][:image_path]!=""
      dir_img_hash=params[:directory_image]
      image_name = "#{dir_img_hash[:image_path].split('/').last.split('.').first}#{Time.now.strftime('%s')}"
      image=Image.create_external_image({:image=>{:image_name=>image_name,:caption=>image_name,:alt_tag=>image_name,:site_id=>@site.id},
                                         :original=>{:image_path=>dir_img_hash[:image_path]},
                                         :thumb=>{:image_path=>dir_img_hash[:thumb_image_path]}})
      if image
        @directory_listing.image = ImageProperty.new()
        @directory_listing.image.image_id = image.id 
        @directory_listing.image.alt_tag = image.alt_tag if image.alt_tag
        @directory_listing.image_id = image.id
      end
    end

    if @directory_listing.save
      flash[:notice] = 'Directory Listing name was successfully created.'
      redirect_to :action => 'index'
    else
      @directory_listing.errors[:contact_details] and @directory_listing.errors.add("contact_details","stats")
      @directory_listing.errors[:contact_details] and @directory_listing.errors[:contact_details].clear
      @directory_listing.contact_details.collect{|detail| detail.errors.each_full{|message| @directory_listing.errors[:base] << message} }
      @directory_listing_categories=@site.directory_listing_categories.find(:all,:select=>"full_name as text,id as value,'directory_listing[directory_listing_category_ids][]' as name").to_json
      render :action => 'new'
    end
  end
  
    def edit
    @page_properties={:selected_menu=>'directory_listing_menu',:menu_title=>'Directory Listing > Edit Directory Listing'}                
    @directory_listing_sponsors=DirectorySponsor.find(:all)    
    @directory_listing = DirectoryListing.find(params[:id])    
    render :action => 'edit'
  end
  
  
  
end

