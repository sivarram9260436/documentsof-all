class Admin::MediaDetailsController < AdminController
  
  def index
    media
  end
  
  def media  
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}                                   
    @flag=params[:set_flag] if params[:set_flag]  
    if request.xhr?     
      render :update do |page|
        page.replace_html 'media_seq',  sr_render_widget(SrComponent.find_component_by_name("media_box_list"))
      end
    else    
      render :action=>"media" ,:layout=> params[:set_flag] ? false :true         
    end   
  end
  
  def media_upload
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}
    render :template=>"/admin/media_details/media_upload",:layout=>false
  end  
  
  def media_upload_save 
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}
#if not params['media_detail']==nil
    @media,status=MediaDetail.upload(params['media_detail']['video_path'],@site) 
    #@media.update_attributes(:caption=> params['media_detail']['caption']) if @media
    @media.update_attributes(:title=>params['media_detail']['title'],:description=>params['media_detail']['description']) if @media
    @set=params[:set][:flage] if params[:set]
    if status
      redirect_to params.merge!({:action=>"edit",:id=>@media.id,:path=>"new"}).merge!(params[:set] ? {:flag=>"true"} : {})
    else
      flash[:notice]="We are accepting only wmv,mp4 and flv formats."
      redirect_to :action=> (params[:set] and params[:set][:flag]=="popup") ? "popup_media_manager" : "media"
    end
#else
   #index  
#end

  end  
  
  def edit     
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}
#    begin
      @path=params[:path] if not params[:path].blank?
      @media=MediaDetail.find(params[:id])
  #    params[:page] = params[:page].blank? ? 1 : params[:page]
      @image_list,@image_path=MediaDetail.set_thumb(@media,params[:page],@site.id,nil,nil) 
      params[:set_flag]="popup" if (params[:flag] or params[:set_flag])
      respond_to do |format|
        format.html do    
          if (params[:flag] or params[:set_flag])    
            render :action => "edit",:layout=>false
          else
            render :action => "edit"
          end
        end
        format.js do        
          render :update do |page|
            page.replace_html 'image_seq', sr_render_widget(SrComponent.find_component_by_name("media_box_image_list"))
          end
        end
      end
#    rescue
#      @media=MediaDetail.find(params[:id])
#      @media.destroy
#      redirect_to :action=>"media"
#    end   
end

 def download
   media=MediaDetail.find (params[:id])
   send_file "#{Rails.root}/public/medias/#{media.id}/#{media.original_file_name}"
 end
  
  def show_selected_image
    
    @default_image_path = params[:id]
    render :layout=>false
  end
  
  def create   
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}
    @media_detail = MediaDetail.find(params[:media][:id])
    #@media_detail.caption = params[:media_detail][:caption] if not params[:media_detail][:caption].blank?
    #@media_detail.update_attributes(:caption => @media_detail.caption) if @media_detail.caption
    if params[:commit]=="Delete"
      @media_detail.delete_media
      redirect_to :action=>"media" if params[:commit]=="Delete" and params[:set_flag]==nil 
      redirect_to :action=>"media",:set_flag=>params[:set_flag] if params[:set_flag]!=nil
    else
      image_name = params[:image][:path].split('/').last
      image=MediaDetail.create_image_for_video("#{Rails.root+'/public'+params[:image][:path]}",@site.id,nil) if params[:image][:path]         
      MediaDetail.change_video_name(@media_detail,params[:media_detail][:upload_file]) if params[:media_detail][:upload_file]       
      @media_detail.update_attributes(:image_id=>image.id) if params[:image][:path]  and image!=nil  
      remove_thumb=File.dirname(Rails.root+'/public/medias/'+@media_detail.id.to_s+'/thumbs')          
      FileUtils.rm_r Dir.glob(remove_thumb+'/*.jpg') 
      redirect_to :action=>"media",:set_flag=>params[:set_flag] if params[:commit]=="Save" and params[:set_flag]!=nil
      redirect_to :action=>"media" if params[:commit]=="Save" and params[:set_flag]==nil
      redirect_to :controller=>"articles",:action=>"new",:media_id=>params[:media][:id] if params[:commit]=="Save + new article"
    end    
  end
  
  def media_videoplay   
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}    
    @media=MediaDetail.find(params[:id])
    @videopath = @media.video_path
    @video_name = @media.name
    @flag= "media_details"
    render :partial=>"play_media"   
  end
  
  def media_search
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video Manager'}     
    render :template=>"/admin/media_details/media"
  end
  
  def popup_media_manager
    @flag="popup"
    if request.xhr?
      render :update do |page|
        page.replace_html 'media_seq', sr_render_widget(SrComponent.find_component_by_name("popup_media_manager"))
      end
    else     
      render :action=>"media",:layout=>false
    end
  end
  
  def popup_media_upload
   @flag="popup"     
   render :layout=>false
  end
  
  
  def search    
    @page_properties={:selected_menu=>'video_list',:menu_title=>'Video List'}
    @value = params[:media_details]
    if request.xhr?
      render :update do |page|
        page.replace_html 'media_seq', sr_render_widget(SrComponent.find_component_by_name("media_search_result"))
      end
    else
      if params[:flag]=="popup"
        @flag=params[:flag] 
        render :action=>"media",:layout=>false
      else
        render :action=>"media"
      end  
    end    
  end 
 
  # Audio

  def audio
    @page_properties={:selected_menu=>'audio_list',:menu_title=>'Audio Manager'}                                   
    @flag=params[:flag] if params[:flag]
    if request.xhr?  
      render :update do |page|
        page.replace_html 'audio_seq', sr_render_widget(SrComponent.find_component_by_name("audio_search_result"))
      end
    else    
      if params[:flag]=="popup"
        @flag=params[:flag]
        render :action=>"audio",:layout=>false
      else
        render :action=>"audio"
      end 
    end
  end
  
  def popup_audio_manager  
    @flag="popup"
    if request.xhr?
      render :update do |page|
        page.replace_html 'audio_seq', sr_render_widget(SrComponent.find_component_by_name("audio_box_list"))
      end
    else           
      render :action=>"popup_audio_manager" ,:layout=>false           
    end
  end
  
  def popup_audio_upload
     @flag="popup"
     @article_flag = "article_flag"
     render :layout=>false, :art_flag=> @article_flag
  end
  
  
  def audio_upload_save
    @page_properties={:selected_menu=>'audio_list',:menu_title=>'Audio Manager'}
    @audios,status=Audio.upload(params['audio']['audio_path'],@site)
    @audios.update_attributes(:title=>params['audio']['title'],:description=>params['audio']['description'],:caption=> params['audio']['caption'] ) if @audios
    if not status
      flash[:notice]="We are accepting only mp3 formats only."
    end
    redirect_to :action=>"audio" #,:flag=>params[:flag]
  end  
  
  def audio_download
    audio=Audio.find(params[:id])
    path="public"+audio.audio_path
    
    send_file(path, :filename =>  "#{audio.name}",:type  =>  'application/flv',:disposition => 'attachment',:streaming =>  'true')
  end 
  
  def audio_search  
    @page_properties={:selected_menu=>'audio_list',:menu_title=>'Audio List'}
    @value = params[:audio]
    @flag=params[:flag] if !params[:flag].blank?  
    if request.xhr?
      render :update do |page|
        page.replace_html 'audio_seq', sr_render_widget(SrComponent.find_component_by_name("audio_search_result"))
      end
    else    
      if params[:flag]=="popup"
        @flag=params[:flag] 
        render :action=>"popup_audio_manager",:layout=>false
      else
        render :action=>"audio"
      end 
      
    end
    
  end  
  
  def edit_audio_detail
    @audio=Audio.find(params[:audio_id])
    render :action=>"edit_audio_detail" ,:layout=>false
  end
  
  def update_audio_detail
     @audio=Audio.find(params[:id])
     @audio.update_attributes(params[:audio])
     flash[:notice]="Audio Details Updated Successfully"
     redirect_to :action=>"audio"
  end
  
end
