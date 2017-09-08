class Admin::PrintManagementController < AdminController
   # before_filter :site_admin,:select_site,:require_authorization
   # before_filter :admin_check_session_expiry
  
  def index
    sort_init "source_id"
    sort_update
    @search_data = SearchData.new(params[:search_data]) if params[:search_data]
    params[:search_data] ||= {}
    params[:order_by]=sort_clause
    params[:site_id]=@site.id
    params[:search_data].merge!(:site_id=>@site.id,:order_by=>sort_clause)
    @page_properties={:selected_menu=>'print_management',:menu_title=>"Issue Management"}
    if request.xhr?
      render :index do |page|         
          page.replace_html 'print_management_index',  component_table_list(SrComponent.find_component_by_name('issue_management_list_new')) 
      end
    end    
  end

 def create_edit
     #@magazine_issue = params[:id] ? MagazineIssue.find(params[:id]) : MagazineIssue.new
    @magazine_issue = params[:id].blank? ?  MagazineIssue.new : MagazineIssue.find(params[:id])
    if params[:magazine_issue] and !params[:magazine_issue][:date_of_publication].blank?
       begin 
        if params[:magazine_issue][:date_of_publication].match(/[a-zA-Z]\s\d{1,2}\S\s\d{4}/)
        params[:magazine_issue][:date_of_publication] =  (params[:magazine_issue][:date_of_publication].to_date.to_time + 1.hours)   
        else
          invalid_date_error = lambda{return "Invalid Date Format"}
         end    
       rescue  
        invalid_date_error = lambda{return "Invalid Date Format"}
       end
    end 

    @magazine_issue.update_attributes(params[:magazine_issue])  if params[:magazine_issue] and !@magazine_issue.new_record?
    (@magazine_issue = MagazineIssue.new(params[:magazine_issue].merge!(:created_by=>session[:user_id])) ).save  if params[:magazine_issue] and @magazine_issue.new_record?  
    @page_properties={:selected_menu=>'print_management',:menu_title=> ((!@magazine_issue.new_record?  and @magazine_issue.errors.empty?) ? "Issue Management > Edit" :  "Issue Management > Create") + " Issue Management"}
    if params[:magazine_issue] and !@magazine_issue.new_record?  and @magazine_issue.errors.empty?
      redirect_to :action=>'index' 
    else
      @magazine_issue.errors.on(:date_of_publication).gsub!("should not be blank",invalid_date_error.call) if invalid_date_error and @magazine_issue.errors.on(:date_of_publication)
      render :action=> 'create_edit'
    end
    image_id = params[:magazine_issue][:image_property][:image_id] if params[:magazine_issue]
    @magazine_issue.image = ImageProperty.new(:image_id => params[:magazine_issue][:image_property][:image_id],:entity_attribute=>"MagazineImage",:caption=> (params[:magazine_issue][:image_property][:caption].blank? ? (nil) : (params[:magazine_issue][:image_property][:caption]))) if image_id !="" and image_id !=nil
  end

  

end