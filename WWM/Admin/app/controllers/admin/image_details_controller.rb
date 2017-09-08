require 'ruby-debug'

class Admin::ImageDetailsController < AdminController
  def index
    imagset_search
  end

  def imageset_list
    imagset_search
  end

  def imagset_search
    @page_properties = {:selected_menu => 'image_list_menu', :menu_title => 'ImageSet Manager'}
    pagination_properites("18")
    # params[:popup_manager] = "popup_manager" if params[:flag] == "popup_manager"
    # (params[:flag] == "popup_manager" || params[:flag] == "tinymce") ?  (@per_page_show = params[:flag]) : ''
    # if params[:flag] == "popup_manager"
    # @res = "popup_manager"
    # @title = params[:title] if !params[:title].blank?
    # elsif params[:flag] == "tinymce"
    # @img_ser = "search_page"
    # @res = "details"
    # else
    # @res = "search_page"
    # @order = params[:image_detail_search][:order_by] if params[:image_detail_search]
    # end
    if request.xhr?
      @partial = true
      render :partial => "/admin/image_details/images_list"
    else
      render :action => "imageset_list"
    end
  end

  def save_multiple_image
    file_name = Util.convert_to_url_string(params[:title].blank? ? request.env['HTTP_X_FILE_NAME'].split('.').first : params[:title]) + "." + request.env['HTTP_X_FILE_NAME'].split(".")[-1]
    @image = Image.save_image(file_name,request.body,@site.id,{:title=>params[:image][:title],:caption=>params[:image][:caption],:licence_type=>params[:image][:licence_type],:image_credits=>params[:image][:image_credits]})
    if @image
      render :text => "Images Uploaded successfully"
    else
      render :text => "Failed to upload"
    end
  end


  def show_preview_imageset
    image = Image.find(params[:id])
    render :text => "<img src='#{image.get_orginal_image.image_path}' class='preview_image' height=300px; width=500px />"
  end

  def get_all_images
    id = params[:image_id] || @site.images.where('status =?',"Active").order('id asc').first.id
    limit = params[:limit] || 10
    @next_images = @site.next_images(id,limit,params)
    @page_properties = { :menu_title => 'Home' ,:context =>@next_images,:page_type =>"gallery_page"}
    render :template=>"/gallery/image-gallery-page",:layout=>@site.get_layout
  end

  def edit_imageset
    @image = Image.find(params[:id])
    render :partial => "edit_imageset"
  end

  def update_imageset_metadata
    @image = Image.find(params[:id])
    @image.status = "Active"
    params_images = params[:image].dup
    params_images[:image_name] = Util.convert_to_url_string(params_images[:image_name])
    @image.update_attributes(params_images)
    @image.rename_image
    flash[:notice] = "Imageset meta data updated successfully"
    redirect_to :action => "imageset_list"
  end

  def crop_imageset
    @image = Image.find(params[:id])
    render :partial => "crop_imageset"
  end

  def edit_orientation
    @image_detail = ImageDetail.find(params[:id])
    @image = @image_detail.image
    if params[:white_background] and params[:white_background] == "true"
    @path = @image_detail.get_crop_img(@image)
    else
      params[:white_background] = "false"
    @path = @image.default_image.image_path
    end
    @width  = @image_detail.image_path.split("-").last.split(".").first.split("x").first
    @height = @image_detail.image_path.split("-").last.split(".").first.split("x").last
    render :partial => "edit_orientation"
  end

  def cropped_imageset_value
    image_detail = ImageDetail.find(params[:id])
    image = image_detail.image
    image_detail.crop_imageset_image(image, image_detail, params[:h], params[:w], params[:x1], params[:y1], params[:x2], params[:y2], params[:resize_height], params[:resize_width], params[:white_background])
    redirect_to :action => "imageset_list"
  end

  def add_image_from_article
    params[:popup] = "true"
   
  end

  def save_image_from_article
    file_name = Util.convert_to_url_string(request.env['HTTP_X_FILE_NAME'].split('.').first) + "." + request.env['HTTP_X_FILE_NAME'].split(".")[-1]
    @image = Image.save_image(file_name,request.body,@site.id)
  if @image
    render :text => @image.id #"Images Uploaded successfully"
  else
    render :text => "Failed to upload"
  end
    
  end


  def insert_image_to_article
    @image = Image.find(params[:id])
    render :partial => "insert_image_to_article"
  end

  def select_inline_image
    @image =Image.find(params[:id])
    @width=params[:width]
    @height=params[:height]
    @image_type=params[:image_type]
    @title=params[:path]
    render :layout=>false
  end

  def show_image_list_step2
    @image =Image.find(params[:id])
    if not params[:title].blank?
      @title=params[:title]
    else
      @title="article"
    end
    render :layout=>false
  end

  # Gallery

  def save_multiple_gallery
    @image=Image.new(params[:image])
    @image.image_name = Util.convert_to_url_string(request.env['HTTP_X_FILE_NAME'].split('.').first)
    @image.alt_tag=@image.image_name
    @image_detail=ImageDetail.new()
    @image.image_details << @image_detail
    tmp_path=@image_detail.generate_image_path_gallery(params[:fileToUpload].path,request.env['HTTP_X_FILE_NAME'])
    @image_detail.update_attributes(:image_path => "#{tmp_path.first}")
    @image.save(:validate => false)
    @image.status = "Active"
    @image.default_version_id = @image.image_details.where(:logical_name => "original").first.id
    @image.original_version_id = @image.image_details.where(:logical_name => "original").first.id
    @image.thumbnail_version_id = @image.get_image('120', '120', 'square').id
    @image.save(:validate => false)
    @image_sequence=ImageSequence.find(params[:image_sequence_id])
    @width,@height,@image_size = @image.get_image_property(@image.image_details.first.image_path)
    @logical_name = @image.image_details.first.logical_name
    @image_property=ImageProperty.new()
    @image_property.update_attributes(:entity_type=>"ImageSequence",:entity_id=>"#{params[:image_sequence_id]}",:image_id=>"#{@image.id}",:width=>"#{@width}",:height=>"#{@height}",:logical_name=>"#{@logical_name}",:name=>"#{params[:image_property][:title]}",:caption=>"#{params[:image_property][:caption]}",:description=>"#{params[:image_property][:description]}")
    @image_property.save(:validate => false)
    @image_sequence.image_properties << @image_property
    @image_sequence.updated_at=Time.sr_now
    @image_sequence.data_proxy_id=Site.find(params[:image][:site_id]).data_proxy_id
    @image_sequence.save(:validate => false)
    render :nothing=>true
  end

  def gallery_sequence_path

    @image_sequence=ImageSequence.new(params[:image_sequence])
    @image_sequence.save
    render :text=>@image_sequence.id
  end

  def gallery_image_path

    @image_sequence= ImageSequence.find(params[:image_sequence_id])
    @im_id=@image_sequence.image_properties.first.image_id
    @image=Image.find(@im_id)
    @image_path=@image.image_details.first.image_path
    render :text=>@image_path
  end
  # Gallery new flow END

  def gallery_list
    @page_properties = {:selected_menu => 'gallery_list', :menu_title => 'Gallery Management'}
    @search_data=SearchData.new(params[:search_data]) if params[:search_data]
    @selected_user= ( User.find session[:user_id]  if params[:search_data] and not params[:search_data][:author_id].blank? ) || []
    sort_init "updated_at"
    sort_update
    respond_to do |format|
      format.html do
        render :action => "gallery_list",:per_page =>session[:per_page]
      end
      format.js do
        render :update do |page|
          page.replace_html 'gallery_list', component_table_list(@site.find_component_by_name("gallery_management_list"))
        end
      end
    end
  end

  def edit_gallery
    @page_properties={:selected_menu=>'gallery_list',:menu_title=>'Gallery > Edit Gallery'}
    @image_sequence=ImageSequence.find(params[:id])

    render :action=>"edit_gallery",:layout=>false if params[:flag] == "edit_gallery"

  # flash[:message] = "Gallery was successfully created."

  end

  def popup_image_manager
    @title=params[:title] if params[:title]
    pagination_properites
    params[:popup_manager]="popup_manager"

    if !request.xhr?
      render :action => "popup_image_manager",:layout=>false
    else
      render :update do |page|
        page.replace 'image_list',sr_render_widget(@site.find_component_by_name("imageset_list"))
      end
    end
  end

  def save_image_to_gallery

    @image_sequence=ImageSequence.find(params[:id])
    if not params[:image_property][:image_id].blank?
      i=0
      for image_property in @image_sequence.image_properties
        i=i+1
      end
      params[:image_property][:sequence_number]= i
      @image_sequence.image_properties << ImageProperty.new(params[:image_property])
    @image_sequence.updated_at=Time.sr_now
    @image_sequence.save
    #      flash[:notice]="Gallery Has Been Saved Successfully "
    end
    redirect_to :action=> "edit_gallery" ,:id=>params[:id]
  end

  def new_gallery
    @page_properties={:selected_menu=>'gallery_list',:menu_title=>'Gallery > Create Gallery'}
  end

  def create_gallery_metadata
    @page_properties={:selected_menu=>'gallery_list',:menu_title=>'Gallery > Create Gallery'}
    @image_sequence=ImageSequence.new(params[:image_sequence])
    if @image_sequence.save
      flash[:message] = "Gallery was successfully created."
      redirect_to :action=>"edit_gallery",:id=>@image_sequence.id
    else
      render :action=>"new_gallery"
    end
  end

  def popup_image_gallery
    pagination_properites
    sort_init "updated_at"
    sort_update
    params[:popup]="true"
    params[:popup_manager]="popup_manager"
    @search=true if not params[:search_data].blank?
    @search_data=SearchData.new(params[:search_data]) if params[:search_data]
    @selected_user= ( User.find(params[:search_data][:author_id]) if params[:search_data] and not params[:search_data][:author_id].blank? ) || []
    params[:search_data][:site_id]=session[:site_id] if params[:search_data]
    params[:search_data][:author_id]=User.find(params[:search_data][:author_id]) if params[:search_data] and !params[:search_data][:author_id].blank?
    @flag="popup"
    if !request.xhr?
      render :action=>"popup_image_gallery"  ,:layout=>false
    else
      render :update do |page|
        page.replace 'gallery_list',sr_render_widget(@site.find_component_by_name("gallery_management_list"))
      end
    end
  end

  def pagination_properites(per_page = nil)
    params[:per_page] = per_page || params[:per_page] || session[:per_page] || "18"
    session[:per_page] = params[:per_page]
  end

  # The below codes for image size related
  def validate_size(size,type)
   if size.include?('x')
    val=[]
    size.split(',').each do |t_size|
      image_size1=t_size.split('x').first
      image_size2=t_size.split('x').second
      case type
      when "SQUARE"
        val << (image_size1.to_i == image_size2.to_i ? true : false)
      when "LANDSCAPE"
        val << (image_size1.to_i > image_size2.to_i ? true : false)
      when "PORTRAIT"
        val << (image_size1.to_i < image_size2.to_i ? true : false)
      end
    end
    return txt = (val.include?(false) ? false :true )
   else
    return false
   end 
  end

  def update_image_size
    @page_properties={:selected_menu=>'image_size_list',:menu_title=>'Image Size'}

    if validate_size(params[:value],params[:type])
      if not params[:value].blank?
        image_size = ImageSize.find_or_create_by_orientation(params[:type],:orientation =>params[:type])
        if image_size.value.blank? 
          image_size.value =  "#{params[:value]}"
        else
          params[:value].split(',').each do |a|
            unless image_size.value.split(",").include?(a)
              image_size.value =  "#{image_size.value},#{a}"
            end
          end
        end
        if image_size.save
          redirect_to :action => "image_size_lists"
        else
          redirect_to :action => "new_image_size"
        end
      end
    else
      flash[:notice]="Please Give Correct Values!"
      redirect_to :action=>"image_size_lists"
    end
  end

  def search_image_size
    @page_properties={:selected_menu=>'image_size_list',:menu_title=>'Image Size'}
    @image_present=ImageSize.where(:orientation=>params[:image_size][:type]).first.value.split(',').include?(params[:image_size][:name])
    @image_present == true ? (render :template=>"image_size_lists" ,:text=>"<font color='green'>Size present do not add </font>") : (render :template=>"image_size_lists",:text=>"<font color='red'>Size  not present do add it </font>")
  end

  def image_size_lists
    @image_sizes = ImageSize.all
    @page_properties={:selected_menu=>'image_size_list',:menu_title=>'Image Size'}
  end

  def new_image_size
    @page_properties={:selected_menu=>'new_image_size',:menu_title=>'New Image Size'}
    @orientation = params[:entity_type]
    @image_sizes = ImageSize.where(:orientation=>params[:entity_type])
    render :partial=>"new_image_size"
  end

  def add_imageset_form_to_gallery
    @image_sequence=ImageSequence.find(params[:id])
    render :partial=>"add_imageset_to_gallery" ,:layout=>false
  end

  def save_image_to_gallery
    @image_sequence=ImageSequence.find(params[:id])
    if not params[:image_property][:image_id].blank?
      i=0
      for image_property in @image_sequence.image_properties
        i=i+1
      end
      params[:image_property][:sequence_number]= i
      @image_sequence.image_properties << ImageProperty.new(params[:image_property])
    @image_sequence.updated_at=Time.sr_now
    @image_sequence.save
    #      flash[:notice]="Gallery Has Been Saved Successfully "
    end
    redirect_to :action=> "edit_gallery" ,:id=>params[:id]
  end

  def edit_imageset_in_gallery

    @image_property=ImageProperty.find(params[:id])
    render :partial=>"edit_imageset_in_gallery",:layout=>false
  end

  def update_imageset_to_gallery
    @image_property=ImageProperty.find(params[:id])
    if params[:commit]!="Close"
      if params[:commit]=="Delete Image"
         if @image_property.entity.image_properties.count==1
           flash[:error]="Image will not delete when gallery is having one image"
         else
           @image_property.delete
         end  
      else
        @image_property.update_attributes(params[:image_property])
      end
      im_seq=ImageSequence.find(:first,:conditions=>["id=?",@image_property.entity_id])
    im_seq.update_attributes(:updated_at=>Time.sr_now)
    end
    redirect_to :action=> "edit_gallery" ,:id=>@image_property.entity_id
  end

  def update_gallery_metadata
    @page_properties={:selected_menu=>'gallery_list',:menu_title=>'Edit Gallery'}
    @image_sequence=ImageSequence.find(params[:id])
    if @image_sequence.update_attributes(params[:image_sequence])
      flash[:notice]="Gallery Has Been Saved Successfully "
      redirect_to :action=> "edit_gallery" ,:id=>params[:id]
    else
      render :action =>"edit_gallery"
    end
  end

  def search_gallery
    @page_properties={:selected_menu=>'gallery_list',:menu_title=>'Gallery Management'}
    @search_data=SearchData.new(params[:search_data]) if params[:search_data]
    @selected_user= ( User.find(params[:search_data][:author_id]) if params[:search_data] and not params[:search_data][:author_id].blank? ) || []
    @search=true
    params[:search_data][:site_id]=session[:site_id] if not EVENTIVE_TEMPLATE_PATH
    params[:search_data][:author_id]=User.find(params[:search_data][:author_id]) if !params[:search_data][:author_id].blank?
    sort_init "updated_at"
    sort_update
    pagination_properites
    if request.xhr?
      render :update do |page|
        page.replace_html 'gallery_list', sr_render_widget(SrComponent.find_component_by_name("gallery_search"))
      end
    else
      render :action => "gallery_list"
    end

  end

  def save_gallery_order
   i=0
   params[:added_image].each{|added_image|     
     im=ImageProperty.find(:first,:conditions=>["id=?",added_image.to_i])
     im.update_attributes(:sequence_number=>i)  
     i=i+1
   }
   im_prop=ImageProperty.find(:first,:conditions=>["id=?",params[:added_image][0].to_i])   
   im_seq=ImageSequence.find(:first,:conditions=>["id=?",im_prop.entity_id])
   im_seq.update_attributes(:updated_at=>Time.sr_now)
   render :text=>"Successfully reordered"
 end
 
end
