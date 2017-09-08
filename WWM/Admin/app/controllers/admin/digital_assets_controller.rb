
class Admin::DigitalAssetsController < AdminController
  def index
    @page_properties={:selected_menu=>'digital_list',:menu_title=>'Asset Manager'} 
    if @site.digital_assets.first==nil
      render :action => "upload_new"
    else
    list
    end  
  end

  def upload_new
  end  
  def list
    @page_properties={:selected_menu=>'digital_list',:menu_title=>'Asset Manager'}   
    respond_to do |format|
      format.html do        
        render :action => "list"
      end
      format.js do        
        render :update do |page|
          page.replace_html 'asset_list', sr_render_widget(@site.find_component_by_name("digital_assest_list"))
        end
      end
    end   
  end
  
  def asset_details
    @location=DigitalAsset.find(params[:id]) if params[:id]!=nil 
    render :action=>"assets_details" ,:layout=>false
  end
  
  def article_asset
    @page_properties={:selected_menu=>'digital_list',:menu_title=>'Asset Manager'}   
    @flag = "article_asset"
    respond_to do |format|
      format.html do        
        render :action => "article_assets_list",:layout=>false
      end
      format.js do        
        render :update do |page|
          page.replace_html 'asset_list', :partial => "article_asset_list"
        end
      end
    end   
  end
  
  def search
    @page_properties={:selected_menu=>'digital_list',:menu_title=>'Asset Manager'}  
    @search=true      
    params[:digital_assets][:name] =  params[:digital_assets][:name].gsub(" ","-") if params[:digital_assets][:name]
    respond_to do |format|
      format.html do      
        if params[:article_doc] and params[:article_doc][:search]=="article_asset"
          @flag="article_asset"
          render :action => "article_assets_list",:layout=>false
        elsif params[:article_doc] and params[:article_doc][:search]=="title_asset_search"
          render :action => "popup_digital_asset_manager",:layout=>false
        else
          render :action => "list"
        end
      end
      format.js do        
        render :update do |page|
          page.replace_html 'asset_list', sr_render_widget(@site.find_component_by_name("digital_assest_search_list"))
        end
      end
    end  
  end
  
  def create
    @page_properties={:selected_menu=>'digital_list',:menu_title=>'Asset Manager'}
    if (params["digital_asset"] and  !params["digital_asset"]["document_path"][".name"].blank? and !params["digital_asset"]["document_path"][".path"].blank?) and DigitalAsset.save_asset(@site,params[:digital_asset].dup,true)
      redirect_to :action=>"js_popupclose"
    else
      flash[:notice]="Please upload only word, excel, pdf, Powerpoint formats documents"
      redirect_to :action => (params[:article_doc_upload]=="article_asset") ? "article_asset" : "index"
    end
  end

  def js_popupclose
    @page_properties={:selected_menu=>'digital_list',:menu_title=>'Asset Manager'}
  end
  
  def upload    
    render :layout=>false
  end
  
  # def update
    # @asset=DigitalAsset.find(params[:id])
    # @asset.update_attributes(params[:digital_asset])
    # @asset.asset_category_ids=[] if params[:digital_asset] and not params[:digital_asset][:asset_category_ids]
    # from_path = @asset.protected ? "public/digital_assets" : "protected/digital_assets"
    # to_path = @asset.protected ? "protected/digital_assets" : "public/digital_assets"
    # debugger
    # FileUtils.mv("#{Rails.root}/#{to_path}", "#{Rails.root}/#{to_path}/old") if File.directory?("#{Rails.root}/#{to_path}")
    # FileUtils.mv("#{Rails.root}/#{from_path}#{@asset.id}","#{Rails.root}/#{to_path}") if File.exist?("#{Rails.root}/#{from_path}#{@asset.id}")
    # @asset.update_attributes(:document_path=>"/#{to_path}#{@asset.id}/#{@asset.name}")
    # redirect_to :action => (params[:article_doc_upload]=="article_asset") ? "article_asset" : "list"
  # end
  
  
  def update
    @asset=DigitalAsset.find(params[:id])
    @asset.update_attributes(params[:digital_asset])
    @asset.asset_category_ids=[] if params[:digital_asset] and not params[:digital_asset][:asset_category_ids]
    time = Time.now.strftime("%d-%m-%y-%H:%M") 
     if @asset.protected?
        path = "protected/digital_assets/"
        if File.directory?("#{Rails.root}/protected/digital_assets/#{@asset.id}")
           FileUtils.mkdir_p("#{time}") if File.directory?("#{Rails.root}/public/digital_assets/#{@asset.id}")
           FileUtils.mv("#{Rails.root}/public/digital_assets/#{Rails.root}","#{Rails.root}/public/digital_assets/#{time}")  if File.directory?("#{Rails.root}/public/digital_assets/#{@asset.id}")
        else
           FileUtils.mv("#{Rails.root}/public/digital_assets/#{@asset.id}", "#{Rails.root}/protected/digital_assets/") if File.directory?("#{Rails.root}/public/digital_assets/#{@asset.id}")
        end
        @asset.update_attributes(:document_path=>"/#{path}#{@asset.id}/#{@asset.name}")
     else
       path = "digital_assets/"
        if File.directory?("#{Rails.root}/public/digital_assets/#{@asset.id}")
           FileUtils.mkdir_p("#{time}") if File.directory?("#{Rails.root}/protected/digital_assets/#{@asset.id}")
           FileUtils.mv("#{Rails.root}/protected/digital_assets/#{@asset.id}","#{Rails.root}/protected/digital_assets/#{time}")  if File.directory?("#{Rails.root}/protected/digital_assets/#{@asset.id}")
        else
           FileUtils.mv("#{Rails.root}/protected/digital_assets/#{@asset.id}", "#{Rails.root}/public/digital_assets/") if File.directory?("#{Rails.root}/protected/digital_assets/#{@asset.id}")
        end
        @asset.update_attributes(:document_path=>"/#{path}#{@asset.id}/#{@asset.name}")
     end
    redirect_to :action => (params[:article_doc_upload]=="article_asset") ? "article_asset" : "index"
  end
  
  def popup_digital_asset_manager 
    params[:per_page]='10' if params[:per_page]==nil and session[:per_page]==nil
    session[:per_page]=params[:per_page] if params[:per_page]!=nil        
    #@docment_details=EVENTIVE_TEMPLATE_PATH ? DigitalAsset.paginate(:all,:per_page=>10,:page=>params[:page]) : @site.digital_assets.paginate(:all,:per_page=>10,:page=>params[:page])                                 
    #params[:popup_manager]="popup_manager"
    #@per_page_show="popup_manager"
    respond_to do |format|
      format.html do
        render :action => "popup_digital_asset_manager",:layout=>false
      end
      format.js do
        render :update do |page|
          page.replace 'asset_list', :partial => "title_document_list"
        end
      end
    end
  end

  def download
      digital_asset=DigitalAsset.find (params[:id])
     if  digital_asset.protected
      send_file "#{Rails.root}/#{digital_asset.document_path}"  
      else 
      send_file "#{Rails.root}/public/digital_assets/#{digital_asset.id}/#{digital_asset.name}"
     end
  end
end
