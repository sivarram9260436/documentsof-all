class Admin::AuthorsController < AdminController
 
   def index
    sort_init "updated_at"
    sort_update
    @page_properties={:selected_menu=>'author_menu',:menu_title=>'Author Profile List'}
    respond_to do |format|
      format.html do
        redirect_to :action => 'index',:layout => false if  request.xhr?
        session[:return_author_path]=request.referer if  request.xhr?
      end
      format.js do
        render :update do |page|
          page.replace_html 'author_list', component_table_list(SrComponent.find_component_by_name('author_management_list'))
        end
      end
    end
  end
 
 
 
 
  def new
    @page_properties={:selected_menu=>'author_menu',:menu_title=>'Author Profile > Create New Author Profile'}
    @author = Author.new
    @author_profile=AuthorProfile.new
    if request.xhr?
      render :layout => false
    end
  end

  def edit
    #sort_init "updated_at"
    #sort_update

    @page_properties={:selected_menu=>'author_menu',:menu_title=>'Author Profile > Edit Author Profile'}
    @sites =Site.find(:all,:select=>"short_name as text,id as value,'author[site_ids][]' as name").to_json
    @author = Author.find(params[:id])
    @author_profile=@author.author_profiles.last || @author.author_profiles.new
    if request.xhr?
      render :layout => false
    end
  end


    def search
    sort_init "firstname"
    sort_update
    @page_properties={:selected_menu=>'author_menu',:menu_title=>'Author Profile List'}
    @search_data = SearchData.new(params[:search_data]) if params[:search_data]
    @authors=Author.normal_search(sort_clause.gsub('?',''), params[:search_data],params[:page],params[:per_page])
    respond_to do |format|
      format.html do
        render :action => 'index'
      end
      format.js do
        render :update do |page|
          page.replace_html 'author_list',  component_table_list(SrComponent.find_component_by_name('author_management_search'))
        end
      end
    end
  end

def create
    @page_properties={:selected_menu=>'author_menu',:menu_title=>'New Author Profile'}
    if not params[:author][:email].blank? and not params[:author][:firstname].blank?
      @author =  Author.find(:first,:conditions=>["UPPER(email)=UPPER(?)",params[:author][:email].strip])
      if @author.blank?
        author = ActiveRecord::Base.connection.execute  "INSERT INTO authors (firstname,email) VALUES (#{Author.sanitize(params[:author][:firstname])},#{Author.sanitize(params[:author][:email])}) RETURNING id"
        author_site = ActiveRecord::Base.connection.execute "INSERT INTO authors_sites (site_id,author_id) VALUES (#{@site.id},#{author.first["id"].to_i})"
        @author =Author.find(author.first["id"].to_i)
      else
        author_site = ActiveRecord::Base.connection.execute "INSERT INTO authors_sites (site_id,author_id) VALUES (#{@site.id},#{@author.id})" unless @author.site_ids.include?(@site.id)
      end
      @author.attributes={:firstname=>params[:author][:firstname], :middle_name=>params[:author][:middle_name], :lastname=>params[:author][:lastname],:active=>params[:author][:active]}
    # else
      # @author = Author.new(:firstname=>params[:author][:firstname], :middle_name=>params[:author][:middle_name], :lastname=>params[:author][:lastname], :email=>params[:author][:email],:active=>params[:author][:active])
    # end
    @author.image_property = params[:author][:image_property] if params[:author][:image_property] and params[:author][:image_property][:image_id]
    @author.company_logo = params[:author][:company_logo] if params[:author][:company_logo] and params[:author][:company_logo][:image_id]
   @author.sites=(Site.where(:id=>params["author"]["site_ids"])||[@site])
   @author.save(:validate=>false)
    #if @author.save
      @author.author_further_readings.collect{|author_article| author_article.destroy if  author_article} if (params[:article] and params[:article][:article_further_reading_ids]).blank?
      params[:article][:article_further_reading_ids].uniq.collect{|article_id,i| @author.author_further_readings << AuthorFurtherReading.create(:author_id=>@author.id,:article_id=>article_id,:sequence_no=>i)} unless (params[:article] and  params[:article][:article_further_reading_ids]).blank?
      @author_profile=AuthorProfile.new(:location=>params[:author_profile][:location],:recommendation=>params[:author_profile][:recommendation],:author_id=>@author.id,:company_name=> params[:author_profile][:company_name], :company_website_url=> params[:author_profile][:company_website_url], :company_linkedin_url=> params[:author_profile][:company_linkedin_url], :twitter_url=> params[:author_profile][:twitter_url], :facebook_url=> params[:author_profile][:facebook_url], :youtube_url=> params[:author_profile][:youtube_url], :title=> params[:author_profile][:title], :professional_title=> params[:author_profile][:professional_title], :description=> params[:author_profile][:description], :meta_title=> params[:author_profile][:meta_title], :meta_description=> params[:author_profile][:meta_description], :meta_keywords=> params[:author_profile][:meta_keywords], :elected_to_speak=> params[:author_profile][:elected_to_speak], :blog_url=> params[:author_profile][:blog_url], :twitter_user_name=> params[:author_profile][:twitter_user_name], :linkedin_url=> params[:author_profile][:linkedin_url], :google_plus=> params[:author_profile][:google_plus], :biography=> params[:author_profile][:biography])
      @author_profile.save
      if params['author']['company_logo'] and not  params['author']['company_logo']['image_id'].blank?
        ImageProperty.create(:entity_attribute=>"CompanyLogo",:image_id=>params['author']['company_logo']['image_id'],:entity_id=>@author.id,:entity_type=>"Author")
      end
      flash[:notice] = 'Author was successfully created.'
      if request.xhr?
        redirect_to :action => 'index',:layout => false
        session[:return_author_path]=request.referer
      else
        redirect_to :action => 'index'
      end
    else
      @author = Author.new(:firstname=>params[:author][:firstname], :middle_name=>params[:author][:middle_name], :lastname=>params[:author][:lastname], :email=>params[:author][:email],:active=>params[:author][:active])
      @author.save
      @author_profile=AuthorProfile.new(:location=>params[:author_profile][:location],:recommendation=>params[:author_profile][:recommendation],:author_id=>@author.id,:company_name=> params[:author_profile][:company_name], :company_website_url=> params[:author_profile][:company_website_url], :company_linkedin_url=> params[:author_profile][:company_linkedin_url], :twitter_url=> params[:author_profile][:twitter_url], :facebook_url=> params[:author_profile][:facebook_url], :youtube_url=> params[:author_profile][:youtube_url], :title=> params[:author_profile][:title], :professional_title=> params[:author_profile][:professional_title], :description=> params[:author_profile][:description], :meta_title=> params[:author_profile][:meta_title], :meta_description=> params[:author_profile][:meta_description], :meta_keywords=> params[:author_profile][:meta_keywords], :elected_to_speak=> params[:author_profile][:elected_to_speak], :blog_url=> params[:author_profile][:blog_url], :twitter_user_name=> params[:author_profile][:twitter_user_name], :linkedin_url=> params[:author_profile][:linkedin_url], :google_plus=> params[:author_profile][:google_plus], :biography=> params[:author_profile][:biography])
      render :action => 'new'
    end
  end



def update

    sort_init "updated_at"
    sort_update
    @page_properties={:selected_menu=>'author_menu',:menu_title=>'Edit Author Profile'}
    @author = Author.find(params[:id])
    params[:author_profile].inspect
    @author_profile=@author.author_profiles.new(params[:author_profile])
    params[:author][:category_ids]=[] if params[:author][:category_ids].blank?
    @author.attributes={:firstname=>params[:author][:firstname], :middle_name=>params[:author][:middle_name], :lastname=>params[:author][:lastname], :email=>params[:author][:email],:active=>params[:author][:active]}
    @author.image_property = params[:author][:image_property] if params[:author][:image_property] and params[:author][:image_property][:image_id]
    @author.company_logo = params[:author][:company_logo] if params[:author][:company_logo] and params[:author][:company_logo][:image_id]
     # @author.sites=[@site]
    @author.sites=(Site.where(:id=>params["author"]["site_ids"])||[@site])

    if @author.save(:validate=>true)
      params[:article][:article_further_reading_ids].uniq.collect{|article_id,i| @author.author_further_readings << AuthorFurtherReading.create(:author_id=>@author.id,:article_id=>article_id,:sequence_no=>i)} unless (params[:article] and  params[:article][:article_further_reading_ids]).blank?
      @author.author_further_readings.collect{|author_article| author_article.destroy if  author_article} if (params[:article] and params[:article][:article_further_reading_ids]).blank?
      @author.save(:validate=>false)
      @author_profile=AuthorProfile.new(:location=>params[:author_profile][:location],:recommendation=>params[:author_profile][:recommendation],:author_id=>@author.id,:company_name=> params[:author_profile][:company_name], :company_website_url=> params[:author_profile][:company_website_url], :company_linkedin_url=> params[:author_profile][:company_linkedin_url], :twitter_url=> params[:author_profile][:twitter_url], :facebook_url=> params[:author_profile][:facebook_url], :youtube_url=> params[:author_profile][:youtube_url], :title=> params[:author_profile][:title], :professional_title=> params[:author_profile][:professional_title], :description=> params[:author_profile][:description], :meta_title=> params[:author_profile][:meta_title], :meta_description=> params[:author_profile][:meta_description], :meta_keywords=> params[:author_profile][:meta_keywords], :elected_to_speak=> params[:author_profile][:elected_to_speak], :blog_url=> params[:author_profile][:blog_url], :twitter_user_name=> params[:author_profile][:twitter_user_name], :linkedin_url=> params[:author_profile][:linkedin_url], :google_plus=> params[:author_profile][:google_plus], :biography=> params[:author_profile][:biography])
      @author_profile.save
      if params['author']['company_logo'] and not params['author']['company_logo']['image_id'].blank?
        @author.company_logo.delete if @author.company_logo
        ImageProperty.create(:entity_attribute=>"CompanyLogo",:image_id=>params['author']['company_logo']['image_id'],:entity_id=>@author.id,:entity_type=>"Author")
      end
      flash[:notice] = 'Author was successfully updated.'
      if  request.xhr?
        render :action => 'index',:layout => false
        session[:return_author_path]=request.referer
      else
        redirect_to :action => 'index'
      end
    else
      render :action => 'edit'
    end
  end

end
