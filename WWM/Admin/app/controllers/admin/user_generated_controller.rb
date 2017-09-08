class Admin::UserGeneratedController < AdminController
  
  def index 
    #pagination_properites(true,"created_at",1)
    params[:search]=true
    #if params[:entity_type] == 'Article' || params[:entity_type] == 'article'
      @page_properties={:selected_menu=>'comment_moderation',:menu_title=>"Comment List"}
   # else
     # @page_properties={:selected_menu=>'comment_moderation',:menu_title=>"Poll Comment Moderation"}
   # end
    session[:per_page]= 25
    @search_data = SearchData.new(params[:search_data]) if params[:search_data]
    params[:search_data] ||= {}
    @comment_type = params[:search_data][:entity_type].blank? ? (params[:entity_type].blank? ? 'Article' : "#{params[:entity_type].classify}") : (params[:search_data][:entity_type])
    params[:search_data][:entity_type] = @comment_type 
   # params[:search_data].merge!(:order_by=>sort_clause)
    if not params[:bulk_action_name].blank?
      params[:comment][:published].each do |comment_id|
        begin
          @comment = Comment.find(comment_id.to_i)
          @comment.update_attributes(:status => params[:bulk_action_name]) if not params[:bulk_action_name] == ""
        rescue
        end       
      end
    end
    respond_to do |format|      
      format.html do            
        render :template=>"/admin/user_generated/index"
      end
      format.js do        
        render :update do |page|             
          page.replace_html 'article_list', component_table_list(SrComponent.find_component_by_name('user_generated_list')) 
        end
      end
    end
  end
  
   
  def user_generated   
    pagination_properites(true,"created_at",30)
    @page_properties={:selected_menu=>'comment_moderation',:menu_title=>"Complaint - Reported Comment List"}
    @comment_type == "Article"
    respond_to do |format|      
      format.html do         
        render :template=>"/admin/user_generated/user_generated"
      end
      format.js do        
        render :update do |page|         
          page.replace_html 'article_list', component_table_list(@site.find_component_by_name('user_generated_list')) 
        end
      end
    end
  end 
  


end
