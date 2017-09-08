class KrDefaultCreation
  def self.default_create
    #["Computer Architecture","Operation System","Hardware","Software","System Architecture","Mobile Configuration"].collect do |tag_name|
#  Tag.create(:name=>tag_name)
#end

##Site Creation
@site_website=Site.create(:name=>"demo_kreatio_cms.com",:short_name=>"cms",:layout_path=>"cms_demo/login",:url=>"cms_demo.com",:domain=>"demo_Kreatio.com",:status=>"Online",:active=>true,:site_type=>"Site" )

if @site_website
Site.transaction do
      #presentation_proxy_id = params[:site_website][:presentation_proxy_id].blank? ? @site_website.presentation_proxy_id : Site.find(params[:site_website][:presentation_proxy_id]).presentation_proxy_id
      #data_proxy_id = params[:site_website][:data_proxy_id].blank? ? @site_website.data_proxy_id : Site.find(params[:site_website][:data_proxy_id]).data_proxy_id
      @site_website.presentation_proxy_id = @site_website.id
      @site_website.data_proxy_id = @site_website.id
      
      source=Source.create(:name=>@site_website,:site_id=>@site_website.id)
      source.site_ids=[@site_website.id]
      
      @site_website.layout_path = "/layouts/#{@site_website.short_name}"
      @site_website.save
      @site_website.template=Template.create(:name =>"Corporate Site")
      @site_website.copy_template(property={:site_website=>{:short_name=>"#{@site_website.short_name}"},:site=>{:template=>"Corporate Site"}})
      #session[:site_id] = @site_website.id  
      #@user = User.find(session[:user_id])
      #@role=SiteUserRole.create(site_id: @site_website.id, user_id: @user.id, role_id: (Role.where(:name=>"Site Admin")).first.id)
      DEFAULT_SITE_PROPERTY_MAPPING.each do |a|
      tmp = DEFAULT_SITE_PROPERTY_MAPPING.with_indifferent_access[a.first]
      config_g =  @site_website.configuration_groups.where(:group_name=>tmp.values_at("group_name").first)   
      if config_g.blank?
          config_group = @site_website.configuration_groups.create(:group_name=>tmp.values_at("group_name").first)
          config_value = config_group.configuration_values.create(:key=>tmp.values_at("congifuration_key").first,:value=>tmp.values_at("congifuration_value").first)
        else
         config_group = @site_website.configuration_groups.where(:group_name=>tmp.values_at("group_name").first).first
         config_value = config_group.configuration_values.create(:key=>tmp.values_at("congifuration_key").first,:value=>tmp.values_at("congifuration_value").first)
      end
    end
     
      end
end
##User Creation
Admin.create(:user=>User.create(:firstname=>"admin",:lastname=>"kreatio",:password=>"77975e33d2088571de01e8f32d7b7a3a",:email=>"admin@kreatio.com",:final_selected_site_id=>Site.first.id))
Admin.create(:user=>User.create(:firstname=>"core",:lastname=>"kreatio",:password=>"77975e33d2088571de01e8f32d7b7a3a",:email=>"core@kreatio.com",:final_selected_site_id=>Site.first.id))
Admin.create(:user=>User.create(:firstname=>"implementation",:lastname=>"kreatio",:password=>"77975e33d2088571de01e8f32d7b7a3a",:email=>"implementation@kreatio.com",:final_selected_site_id=>Site.first.id))
Admin.create(:user=>User.create(:firstname=>"testing",:lastname=>"kreatio",:password=>"77975e33d2088571de01e8f32d7b7a3a",:email=>"testing@kreatio.com",:final_selected_site_id=>Site.first.id))


##Role Creation and Assignment for the site
self.create_roles

##### Permission Creation
self.permission_creation




SiteUserRole.create(:user=>User.find_by_firstname("admin"),:role=>Role.find_by_name("Site Admin"),:site=>Site.first)
SiteUserRole.create(:user=>User.find_by_firstname("admin"),:role=>Role.find_by_name("Content Admin"),:site=>Site.first)

SiteUserRole.create(:user=>User.find_by_firstname("core"),:role=>Role.find_by_name("Site Admin"),:site=>Site.first)
SiteUserRole.create(:user=>User.find_by_firstname("core"),:role=>Role.find_by_name("Content Admin"),:site=>Site.first)

SiteUserRole.create(:user=>User.find_by_firstname("implementation"),:role=>Role.find_by_name("Site Admin"),:site=>Site.first)
SiteUserRole.create(:user=>User.find_by_firstname("implementation"),:role=>Role.find_by_name("Content Admin"),:site=>Site.first)

SiteUserRole.create(:user=>User.find_by_firstname("testing"),:role=>Role.find_by_name("Site Admin"),:site=>Site.first)
SiteUserRole.create(:user=>User.find_by_firstname("testing"),:role=>Role.find_by_name("Content Admin"),:site=>Site.first)



##Template And Section Assignment
{"News"=>["Article","News"],"static-page"=>["Static","static-page"],"dynamic-page"=>["Static","dynamic-page"],"fragment"=>["Static","static-fragment"]}.each do |template_name,section_related|
 Template.create(:name=>template_name,:sections=>[Section.create(:name=>section_related[1],:entity_type=>section_related[0])])
end

default_properties={"article_page"=>['home','@section','@category'], "section_page"=>['home','@section'],"category_page"=>['home','@category'],"section_category_page"=>['home','@section','@category'],"section_tag_page"=>['home','@section','@tag'],"tag_page"=>['home','@tag'],"source_page"=>['home','@source'],"source_section_page"=>['home','@source','@section'],"static_page"=>['home','@static_page'],"category_and_source_page"=>['home','@category','@source']}
default_properties.each do |tmp|
p=Page.new(:page_name=>tmp.first)
p.type='Defaultpage'
p.save
pp=p.page_properties.create(:key=>"breadcrumb")
tmp.last.each do  |breadcrumb|
 pp.breadcrum_values.create(:display=>breadcrumb)
end
p.page_properties.create(:key=>"mainmenu",:value=>tmp.first)
end 



  end
  
  def self.create_roles
      all_roles_for_admin=["Site Admin","Developer",]
      all_roles_for_author=["Author","Editor","Ranking","Designer","HTML Editor","Content Admin"]
      for role_name in all_roles_for_admin
        role=Role.new
        role.name=role_name
        role.user_type="Admin"
        role.save
      end 
      for role_name in all_roles_for_author
        role=Role.new
        role.name=role_name
        role.user_type="Author"        
        role.save
      end 
      all_permissions_for_author=["Content","Ranked List","Slide Show","Images","Media","Polls","Digital Assets","Pic of the Day (INQ only)"]
      all_permissions_for_admin=["Site","Menu","Taxonomy","Tag","Roles","User","Components","Authentication"]
      for permission_for_author in all_permissions_for_author
        permis=Permission.new
        permis.short_name=permission_for_author
        permis.user_type="Author"          
        permis.save
      end
      for permission_for_admin in all_permissions_for_admin
        permis=Permission.new
        permis.short_name=permission_for_admin
        permis.user_type="Admin"                    
        permis.save
      end
      all_actions=[["manage_articles","Manage Articles",["Content Admin","Author","Editor","Designer"],"Content"],["delete_aticle","Delete Article",["Editor"],"Content"],["workflow_unpublish","Workflow - Unpublish",["Editor","Content Admin"],"Content"],["workflow_save","Workflow - Save",["Content Admin","Author","Editor"],"Content"],["workflow_submit","Workflow - Submit",["Content Admin","Author","Editor"],"Content"],["workflow_publish","Workflow - Publish",["Content Admin","Editor"],"Content"],["view_history","View History",["Content Admin","Author","Editor"],"Content"],["html_editing","HTML Editing",["Developer","Designer","HTML Editor"],"Content"],["admin_ranklist","Admin Ranklist",["Site Admin","Developer"],"Ranked List"],["manage_ranklist","Manage Ranklist",["Site Admin","Ranking"],"Ranked List"],["manage_slideshow","Manage Slideshow",["Content Admin","Developer"],"Slide Show"],["manage_images","Manage Images",["Content Admin","Author","Editor","Designer"],"Images"],["delete_images","Delete Images",["Content Admin"],"Images"],["manage_media","Manage Media",["Content Admin","Author","Editor"],"Media"],["delete_media","Delete Media",["Content Admin"],"Media"],["manage_poll","Manage Poll",["Content Admin","Author","Editor"],"Polls"],["place_poll","Place Poll (Rank?)",["Content Admin","Editor"],"Polls"],["delete_poll","Delete Poll",["Content Admin"],"Polls"],["manage_assets","Manage Assets",["Content Admin","Author","Editor"],"Digital Assets"],["delete_assets","Delete Assets",["Content Admin"],"Digital Assets"],["manage_pic_of_the_day","Manage Pic of the Day",["Content Admin","Editor"],"Pic of the Day (INQ only)"],["site_management","Site Management",["Site Admin","Developer"],"Site"],["menu_management","Menu Management",["Site Admin","Developer"],"Menu"],["taxonomy_management","Taxonomy Management",["Site Admin","Developer"],"Taxonomy"],["tag_management","Tag Management",["Site Admin","Developer"],"Tag"],["role_management","Role Management",["Site Admin"],"Roles"],["user_management","User Management",["Site Admin"],"User"],["component_management","Component Management",["Site Admin","Developer"],"Components"],["authentication_management","Authentication Management",["Site Admin","Authentication"],"Authentication"]]
      for action in all_actions
        act=SubPermission.new
        act.short_name=action[0]
        act.name=action[1]
        permission_manoj = Permission.find_by_short_name(action[3])
        act.permission_id=permission_manoj.id unless permission_manoj.blank?
        
        act.role_ids=action[2].collect do |role_name| 
          role_manoj = Role.find_by_name(role_name)
          role_manoj.blank? ? nil : role_manoj.id
          end.compact
          
          act.save
        end 
      end  
      
      
  def self.permission_creation
          permission=Permission.create(:short_name=>"Content Modifier Dashboard",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Manage Dashboard",:short_name=>"manage_content_modifier_dashboard")])
      permission= Permission.find_by_short_name("Content Modifier Dashboard")
      Role.find_all_by_user_type("Author").each do |role_assignment|
        role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
        role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
        role_assignment.save
      end
      
      permission=Permission.create(:short_name=>"Site Modifier Dashboard",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Manage Dashboard",:short_name=>"manage_site_modifier_dashboard")])
      permission= Permission.find_by_short_name("Site Modifier Dashboard")
      Role.find_all_by_user_type("Admin").each do |role_assignment|
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      end
      
      
      permission=Permission.create(:short_name=>"Product Creteria Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Product Creteria Management",:short_name=>"product_criteria_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      
      permission=Permission.create(:short_name=>"Featured Management",:user_type=>"Author",:sub_permissions=>[SubPermission.create(:name=>"Featured Management",:short_name=>"get_featured")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      # sub=SubPermission.find_by_short_name("questionnaires_management")
      # a=Role.find_by_name("Site Admin")
      # a.sub_permission_ids.delete(sub.id)
      # sub2=SubPermission.find_by_short_name("questions_management")
      # a.sub_permission_ids.delete(sub2.id)
      # a=Role.find_by_name("Content Admin")
      # a.sub_permission_ids = (a.sub_permission_ids << sub2.id)
      # a.sub_permission_ids = (a.sub_permission_ids << sub.id)
      # per=Permission.find_by_short_name("Question Management")
      # per.roles=[Role.find_by_name("Content Admin")]
      # per.user_type="Author"
      # per.save
      # per=Permission.find_by_short_name("Questionnaires")
      # per.roles=[Role.find_by_name("Content Admin")]
      # per.user_type="Author"
      # per.save
      
      
      permission=Permission.create(:short_name=>"Static Page Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Static Page Management",:short_name=>"static_management")])
      permission= Permission.find_by_short_name("Static Page Management")
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Author Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Author Management",:short_name=>"author_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Comment Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Comment Management",:short_name=>"comment_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Print Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Print Management",:short_name=>"print_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Directorylisting Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"DirectoryListing Management",:short_name=>"directory_listing_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Directorylisting Category Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"DirectoryListing Category Management",:short_name=>"directory_categories_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Directorylisting Service Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"DirectoryListing Service Management",:short_name=>"services_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Authentication Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Authentication Management",:short_name=>"authentication_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Component Cache Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Component Cache Management",:short_name=>"component_cache_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"User Information Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"User Setting",:short_name=>"user_self_setting")])
      role_assignments=Role.all
      for role_assignment in role_assignments
        role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
        role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
        role_assignment.save
      end
      
      
      permission=Permission.create(:short_name=>"Admin Collection Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Admin Manage Ranked List",:short_name=>"admin_manage_ranklist")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Admin Poll Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Admin Poll Management",:short_name=>"admin_poll_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Product Creteria",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Product Creteria Management",:short_name=>"authentication_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Page Cache Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Page Cache Management",:short_name=>"page_cache_expiry")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Group Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Group Management",:short_name=>"group_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Newsletter Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Newsletter Management",:short_name=>"newsletter_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      # role_assignment=Role.find_by_name("Content Administrator")
      # role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      # role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      # role_assignment.save
      
      permission=Permission.create(:short_name=>"Static Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Static Management Flow",:short_name=>"admin_static_page_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Asset Category Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Asset Category Management",:short_name=>"asset_category_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Blog Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Blog Management",:short_name=>"blog_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Gallery Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Gallery Management",:short_name=>"gallery_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Forum Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Forum Management",:short_name=>"forum_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Share Cast Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Share Cast Management",:short_name=>"share_cast_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Related Companies Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Related Companies Management",:short_name=>"related_companies_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Debate Content Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Debate Content Management",:short_name=>"debate_content_management")])
      role_assignment=Role.create(:name => "Debate", :user_type => "Author")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Debate Admin Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Debate Admin Management",:short_name=>"debate_admin_management")])
      role_assignment=Role.create(:name => "Debate Admin", :user_type => "Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Page Management",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"Page Management",:short_name=>"page_management")])
      role_assignment=Role.create(:name => "Page Admin", :user_type => "Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      # permission=Permission.create(:short_name=>"Section Management",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"Section Management",:short_name=>"section_management")])
      # role_assignment=Role.create(:name => "Section Admin", :user_type => "Admin")
      # role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      # role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      # role_assignment.save
      # 
      # permission=Permission.create(:short_name=>"Source Management",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"Source Management",:short_name=>"source_management")])
      # role_assignment=Role.create(:name => "Source Admin", :user_type => "Admin")
      # role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      # role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      # role_assignment.save
      
      permission=Permission.create(:short_name=>"Data Management",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"Data Management",:short_name=>"datalist_management")])
      role_assignment=Role.create(:name => "Site Admin", :user_type => "Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      # 
      # 
      permission=Permission.create(:short_name=>"DataList Manager",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"DataList Manager",:short_name=>"datalist_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Page Manager",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"Page Manager",:short_name=>"page_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Event Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Event Management",:short_name=>"event_calender_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Component Management",:user_type=>"Admin",:sub_permissions=>[SubPermission.create(:name=>"Component Management",:short_name=>"component_management")])
      role_assignment=Role.create(:name => "Data Admin", :user_type => "Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Collection Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Collection Management",:short_name=>"admin_manage_ranklist")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = role_assignment.sub_permission_ids + permission.sub_permission_ids#(role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Questionnaires",:user_type=>"Author",
      :sub_permissions=>[SubPermission.create(:name=>"Questionannaire",:short_name=>"questionnaires_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.find_by_short_name("Questionnaires")
      sub_permissions=SubPermission.create(:name=>"Questionannaire",:short_name=>"questions_management",:permission_id=>permission.id)
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      # permission=Permission.create(:short_name=>"Questionnaires",:user_type=>"Author",
      # :sub_permissions=>[SubPermission.create(:name=>"Questionannaire",:short_name=>"questionnaire_data_management")])
      # role_assignment=Role.find_by_name("Content Admin")
      # role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      # role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      # role_assignment.save
      # 
      # 
      # permission=Permission.create(:short_name=>"Questionnaires",:user_type=>"Author",
      # :sub_permissions=>[SubPermission.create(:name=>"Questionannaire",:short_name=>"questions_management")])
      # role_assignment=Role.find_by_name("Content Admin")
      # role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      # role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      # role_assignment.save
      
      permission=Permission.create(:short_name=>"Additional Data",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Additional Data",:short_name=>"additional_data")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Fourm Maganement",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Fourm Maganement",:short_name=>"forum_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"NewsWireFeed Maganement",:user_type=>"Author",
      :sub_permissions=>[SubPermission.create(:name=>"NewsWireFeed Maganement",:short_name=>"news_wire_feeds_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Image Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Image Management",:short_name=>"manage_images")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Source Maganement",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Source Maganement",:short_name=>"source_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Section Maganement",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Section Maganement",:short_name=>"section_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Static Page Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Static Page Management",:short_name=>"static_management")])
      permission= Permission.find_by_short_name("Static Page Management")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Admin Collection Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Admin Manage Ranked List",:short_name=>"admin_manage_ranklist")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Admin Poll Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Admin Poll Management",:short_name=>"admin_poll_management")])
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Competition Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Competition Management",:short_name=>"competition")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Classifiedlisting Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"ClassifiedListing Management",:short_name=>"classified_listing_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Classifiedlisting Category Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"ClassifiedListing Category Management",:short_name=>"classified_categories_management")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"Layout Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Layout Management",:short_name=>"layout_menu")])
      permission= Permission.find_by_short_name("Layout Management")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Site Creation Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Site Creation Management",:short_name=>"site_creation")])
      permission= Permission.find_by_short_name("Site Creation Management")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      
      permission=Permission.create(:short_name=>"User Announcement Management",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"User Announcement Setting",:short_name=>"user_annousment")])
      role_assignments=Role.all
      for role_assignment in role_assignments
        role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
        role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
        role_assignment.save
      end
      
      permission=Permission.create(:short_name=>"Webnish Manager",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Webnish Manager",:short_name=>"webnish_manager")])
      permission= Permission.find_by_short_name("Webnish Manager")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Subscription",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Subscription",:short_name=>"subscription")])
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Vertical Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Vertical Management",:short_name=>"vertical_management")])
      permission= Permission.find_by_short_name("Vertical Management")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Robot Management",:user_type=>"Admin",
                        :sub_permissions=>[SubPermission.create(:name=>"Robot Management",:short_name=>"robot_management")])
      permission= Permission.find_by_short_name("Robot Management")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Subscriber Report",:user_type=>"Author",
                        :sub_permissions=>[SubPermission.create(:name=>"Subscriber Report Management",:short_name=>"subscriber_report_management")])
      permission= Permission.find_by_short_name("Subscriber Report")
      role_assignment=Role.find_by_name("Content Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
      
      permission=Permission.create(:short_name=>"Image Size Management",:user_type=>"Admin",
                  :sub_permissions=>[SubPermission.create(:name=>"Image Size Management",:short_name=>"image_size_management")])
      permission= Permission.find_by_short_name("Image Size Management")
      role_assignment=Role.find_by_name("Site Admin")
      role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
      role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
      role_assignment.save
  end 
  
  def self.image_size_addition
    ImageSize.create(:orientation=>"PORTRAIT",:value=>"286x288,190x191,203x254,343x347,112x150,149x191,74x99,80x129,100x162,120x194,140x227,150x243,170x275,185x299,230x372,270x437,320x518,370x599,540x874,580x938,190x192,154x211,74x75,282x800")
    ImageSize.create(:orientation=>"LANDSCAPE",:value=>"120x100,113X75,113x75,297x212,145x144,301x214,275x149,289x282,337x223,224x148,111x73,187x106,677x638,317x223,188x124,300x250,149x99,150x99,225x99,100x80,80x49,100x62,120x74,140x87,150x93,170x105,185x114,230x142,270x167,320x198,370x229,540x334,580x358,600x400,685x476,300x200,439x299,455x302 ,400x281,452x322,452x312,931x334,300x191,568x360,565x362,278x198,222x157,228x150,282x200,191x139,176x125,187x120,150x109,454x321,277x200,444x296,454x312,194x140,646x429,1600x572,455x302")
    ImageSize.create(:orientation=>"SQUARE",:value=>"60x60,62x63,353x353,100x100,189x189,53x53,150x150,121x121,147x147,264x264,200x200,223x223,120x120,140x140,170x170,185x185,230x230,270x270,320x320,370x370,540x540,580x580,450x450,80X80,343x343,96x96,115x115")
  

  end   
  
  def self.directory_creation
    Directory.create(:name=>"Kreatio Demo",:alias_name=>"kreatio_demo",:site_id=>Site.first.id)
  end
end