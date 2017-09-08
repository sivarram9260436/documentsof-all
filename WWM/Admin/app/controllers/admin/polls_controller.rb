class Admin::PollsController < AdminController
  
  def index
    @page_properties={:selected_menu=>'poll_menu',:menu_title=>'Poll List'}
     sort_init "updated_at"
     sort_update
    respond_to do |format|
      format.html do
        render :action => 'index'
      end
      # format.js do
        # render :update do |page|
          # if !params.blank? && !params[:search_data].blank? && !params[:search_data]["question"].blank? && !params[:search_data]["status"].blank?
            # page.replace_html 'poll_new_list', component_table_list(@site.find_component_by_name('poll_list_search'))
            # else
            # page.replace_html 'poll_new_list', component_table_list(@site.find_component_by_name('poll_list_new'))  
            # end
        # end
      # end
    end   
  end
  
  def new
    @page_properties={:selected_menu=>'poll_menu',:menu_title=>'Poll > Create New Poll'}
    @poll=Poll.new
  end

  def edit
    @page_properties={:selected_menu=>'poll_menu',:menu_title=>'Poll > Edit Poll'}
    @poll=Poll.find(params[:id])
  #@reset="yes"
  end


end
