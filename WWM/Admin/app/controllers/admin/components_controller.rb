class Admin::ComponentsController < AdminController
 

  def component_tree_view
    @page_properties={:selected_menu=>'component_menu',:menu_title=>'Tree View'}
  end

 
  def new_widget
    @page_properties={:selected_menu=>'widget_menu',:menu_title=>'Create Widget'}
    @new_widget=Widget.new
    c=SrComponent.find_component_by_name("latest_article_tabs").dup
    data_string=c.merge!({:data_string => %q{{:data => Component.find(:all,:conditions =>['presentation_proxy_id is null']).paginate(:per_page => 10, :page => params[:page]), :type => 'latest', :results => Component.all.paginate(:per_page => 10, :page => params[:page])}}})
    if !!request.xhr?
      render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@latest_articles,:type =>'latest',:component_hash => data_string}
    else
      render :action => 'new_widget'
    end
  end

  def create_widget
    @page_properties={:selected_menu=>'widget_menu',:menu_title=>'Create Widget'}
    @new_widget=Widget.create(params[:widget])
    @new_widget.create_widget(params[:container].split(','),params[:widget][:name],@site)
    flash[:notice] = 'Widget successfully created.'
    redirect_to :action => 'list_widget'
  end

  def list_widget
    @page_properties={:selected_menu=>'widget_menu',:menu_title=>'Widget List'}
  end

  def edit_widget
    @page_properties={:selected_menu=>'widget_menu',:menu_title=>'Edit Widget'}
    @widget=Widget.find(params[:id])
    c=SrComponent.find_component_by_name("latest_article_tabs").dup
    data_string=c.merge!({:data_string => %q{{:data => Component.find(:all,:conditions =>['presentation_proxy_id is null']).paginate(:per_page => 10, :page => params[:page]), :type => 'latest', :results => Component.all.paginate(:per_page => 10, :page => params[:page])}}})
    if !!request.xhr?
      render :partial => '/admin/ajax_partials/pagination_list' ,:locals =>{:results=>@latest_articles,:type =>'latest',:component_hash => data_string}
    else
      render :action => 'new_widget'
    end
  end

  def update_widget
    @page_properties={:selected_menu=>'widget_menu',:menu_title=>'Widget List'}
    @widget=Widget.find(params[:id])
    #@widget=@widget.update_attributes(params[:widget])
    @widget.create_widget(params[:container].split(','),params[:widget][:name],@site)
    flash[:notice] = 'Widget successfully updated.'
    redirect_to :action => 'list_widget'
  end

  def list_partials
    @page_properties={:selected_menu=>'partial_menu',:menu_title=>'Partial List'}
    if Partial.all.empty?
      Partial.create(:partial_type => "partial")
      Partial.create(:partial_type => "decoration")
    end
  end

  def create_partials
    @page_properties={:selected_menu=>'partial_menu',:menu_title=>'Partial List'}
    partial=Partial.new
    if params[:partials]
      params[:partials][:key].split(",").flatten.each do |a|
        par=a.split(":")
        partial.partial(@site.id,par[0],par[1])
      end
    end
    if params[:decoration]
      params[:decoration][:decoration_list].each do |a|
        partial.decoration(@site.id,a)
      end
    end
    redirect_to :action=>"list_partials"
  end


end
