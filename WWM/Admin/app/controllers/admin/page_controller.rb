class Admin::PageController  < AdminController
  

  def special_page
    @page_properties={:selected_menu=>'special_menu',:menu_title=>'Page Manager'}
    @action_type=params[:action_type]
    @page= @site.special_pages.new
    @page.active=true
    render :layout => false
  end

  def special_page_list
    session[:per_page] = ( params[:per_page] ||= session[:per_page] || "30" ) 
    # @active=para
    @page_properties={:selected_menu=>'special_menu',:menu_title=>'Speacial Page Manager'}
    @type=params[:type]
     @selected=params[:selected]
    #render :layout => false
  end

 

  def create_special_page
    @page_properties={:selected_menu=>'special_menu',:menu_title=>'Page Manager'}
    params[:page][:active] = true if params[:page][:active] == "active"
    @page=@site.pages.new(params[:page])
    @page.site=@site
    @page.create_page_template(@site,"special_pages",params[:page][:template])
    @page.type=params[:page][:type]
    @page.layout_required=true if params[:page][:layout_required] == "on"
    @page.layout=(params[:page][:layout_required]!="on" ? nil : params[:page][:layout])
    if @page.save
       search_data=SrComponent.find_component_by_name('special_page_list')
       search_data[:data_string]= %q{@site.all_special_pages.paginate(:per_page =>5, :page => params[:page_number]).order('updated_at desc')}
       render :partial => 'admin/ajax_partials/component_table_list' ,:locals =>{:page => params[:page_number],:component_hash => search_data}
    else
           error_message = "<b>Errors-</b><ul class=''><li>" + @page.errors.full_messages.join('</li><b></b><li>') + '</li></ul>'
       render :text => error_message, :layout => false,:status=>201
    end
  end

  def update_special_page
    @page_properties={:selected_menu=>'special_menu',:menu_title=>'Page Manager'}
    @special_page= @site.all_special_pages.find(params[:id])
    @special_page.update_attributes(params[:page])
    @special_page.create_page_template(@site,"special_pages",params[:page][:template])
    @special_page.layout_required =(params[:page][:layout_required].nil? ? false : true)
    @special_page.layout=(params[:page][:layout_required].nil? ? nil : params[:page][:layout])
     if @special_page.save
     search_data=SrComponent.find_component_by_name('special_page_list')
     search_data[:data_string]= %q{@site.all_special_pages.paginate(:per_page =>5, :page => params[:page_number]).order('updated_at desc')}
     render :partial => 'admin/ajax_partials/component_table_list' ,:locals =>{:page => params[:page_number],:component_hash => search_data}
     else
     error_message = "<b>Errors-</b><ul class=''><li>" + @page.errors.full_messages.join('</li><b></b><li>') + '</li></ul>'
     render :text => error_message, :layout => false,:status=>201
     end
    end

  def special_page_edit
    @page_properties={:selected_menu=>'special_menu',:menu_title=>'Page Manager'}
    @page= @site.all_special_pages.find(params[:id])
    @action_type=params[:action_type]
    render :layout => false
  end
 
 def entity_type
   @page_properties={:selected_menu=>'page_management',:menu_title=>'Bredcrum Manager'}
   page_property=PageProperty.find(params[:page_property])
   @value_breadcrum = page_property.breadcrum_values.first
   @action_type=params[:action_type]
   render :template=>"/admin/page/action_type",:layout=>false
 end
    
def edit_page_properties
      @page_properties={ :selected_menu => 'pages_menu', :menu_title => 'Site Clone' }
      @site_website=Ambient.current_site
      @page=Page.find(params[:id])
      render :layout=>false 
end
     


  def list_breadcrums
      @page_properties={:selected_menu=>'pages_menu',:menu_title=>'Page Property'}
  end
  
  def value_breadcrum
    @page_properties={:selected_menu=>'pages_menu',:menu_title=>'Bredcrum Manager'}
    @page=Page.find(params[:page_id])
    @page_property=PageProperty.find(params[:id])
    @value_breadcrum =  @page_property.breadcrum_values.blank? ? (@page_property.breadcrum_values.new()) : (@page_property.breadcrum_values.first)
    render :layout=>false
  end
 

end
