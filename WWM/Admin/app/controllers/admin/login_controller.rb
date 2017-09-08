class Admin::LoginController < AdminController

  def dashboard
    @user = User.find(session[:user_id])
    @page_properties={:selected_menu=>'home_menu',:menu_title=>"Articles for Approval"}
    @search_data = SearchData.new(params[:search_data]) if params[:search_data]
    # if params[:flag]
    # @comments=Comment.by_reported(@site.id).sr_paginate(:all,:order=>sort_clause,:per_page =>30,:page => params[:page])
    # else
    @announcements=SupportMessage.find(:all,:conditions=>["status=?",true],:order=>'created_at desc',:limit=>3)
    @bookmarks=@user.bookmark_details.find(:all,:order=>"created_at desc",:limit=>5)
    @articles_by_user=@site.all_articles.not_older_than_by_updated_at(6.months.to_i).find_all_by_created_by(@user.id,:limit=>5,:order=>'updated_at desc')
    sort_init "updated_at"
    sort_update
    respond_to do |format|
      format.html do
        render :template=>"/admin/home/dashboard"
      end
      format.js do
        render :update do |page|
          page.replace_html 'dashboard_articles',:partial => "admin/home/unpublished_article"
        # page.replace_html 'article_list', component_table_list(@site.find_component_by_name("article_list"))
        end
      end
    end
  end


end
