class Admin::ServicesController < AdminController
  # before_filter :site_admin,:select_site
  # before_filter :admin_check_session_expiry
  # layout 'sites'

  def index
    sort_init "name"
    sort_update
    @page_properties={:selected_menu=>'service_menu',:menu_title=>'Directory Listing Service/Product Manager'}                
    session[:per_page] = ( params[:per_page] ||= session[:per_page] || "30" )
    respond_to do |format|
      format.html do
        render :action => 'index'
      end
      format.js do        
        render :update do |page|
          page.replace_html 'list_services',component_table_list(SrComponent.find_component_by_name('ServiceList')),:page => params[:page]
        end
      end
    end
  end
  
    def new
   
    @page_properties={:selected_menu=>'service_menu',:menu_title=>'Service/Product > Create New Service/Product'} 
    @service=@site.services.new  
    @sites =Site.find(:all,:select=>"short_name as text,id as value,'service[site_ids][]' as name").to_json
    if params[:type]=="site"
       render :template => 'admin/services/new',:layout => @site.get_layout unless IS_ADMIN
    end
  end

 def edit
    @page_properties={:selected_menu=>'service_menu',:menu_title=>'Service/Product > Edit Service/Product'}                
    @sites = Site.find(:all,:select=>"short_name as text,id as value,'service[site_ids][]' as name").to_json
    @service = @site.services.find(params[:id])    
    render :action => 'edit'
  end


end
