class Wps::IssuesController < WpsController
  include Rails.application.routes.url_helpers
  def show_issue_page
    @source=@site.sources.find_by_alais_name(params[:source_name])
    find_magazine_issues
    #@selected_menu=@site.get_selected_menu(:others=>"Home")
    @selected_menu = @site.get_listing_selected_menu(request.path) || @site.get_selected_menu(:others=>"Home")
    if @source and @magazine_issue
      @page_properties={:menu_title=>"#{@source.alias_name} - [#{@magazine_issue.short_name.capitalize}]",  :entities => @magazine_issue , :page_type => "issue_page",:context =>@magazine_issue}
      #@actual_url=url_for_issue_page_path(@magazine_issue.short_name.capitalize,@source,@magazine_issue,nil,{:only_path=>true})
      render :template=>@site.get_issue_page,:layout=>@site.get_layout
    #@actual_url=url_for_issue_page_path_for_rss(@source,@magazine_issue,{:only_path=>true})
    #redirect_if_different_url || (render :template=>"#{@site.get_issue_page}-rss",:layout=>false)
    else
      render_404
    end
  end

end
