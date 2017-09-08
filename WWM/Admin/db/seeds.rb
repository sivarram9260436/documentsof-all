# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
puts "********Seeding Menu Data Start************"
menu_article=Menu.create(:parent_id=>0,:name=>"Articles",:alias_name=>"article_menu",:sequence_number=>2,:action_name=>"index",:controller_name=>"admin/articles", :menu_access=>"admin")
Menu.create(:parent_id=>menu_article.id,:name=>"ArticleListing",:alias_name=>"article_list_menu",:sequence_number=>1,:action_name=>"index", :controller_name=>"admin/articles",:menu_access=>"admin")
Menu.create(:parent_id=>menu_article.id,:name=>"Article New",:alias_name=>"article_menu",:sequence_number=> 2,:action_name=>"new",:controller_name=> "admin/articles",:menu_access=>"admin")

ranked_list_menu = Menu.create(:parent_id=>0,:name=>"Collections",:alias_name=>"ranked_list_menu",:sequence_number=>4,:action_name=>"index",:controller_name=>"admin/ranked_list",:menu_access=>"admin")
Menu.create(:parent_id=>ranked_list_menu.id,:entity_type=>"digital_asset",:name=>"Digital Asset Collections",:alias_name=>"ranked_list_digital_asset_menu", :sequence_number=>2, :action_name=> "index", :controller_name=>"admin/ranked_list", :menu_access=> "admin")

Menu.create(:parent_id=>0,:name=>"Component Cache",:alias_name=>"component_cache_management",:action_name=>"index",:controller_name=>"admin/component_cache",:menu_access=>"admin")

asset_menu = Menu.create(:parent_id=>0,:name=>"Assets",:alias_name=>"image_list_menu",:sequence_number=>6,:action_name=>"imageset_list",:controller_name=>"admin/image_details",:menu_access=>"admin")
Menu.create(:parent_id=>asset_menu.id,:name=>"Image",:alias_name=>"image_list_menu",:sequence_number=>1,:action_name=>"imageset_list",:controller_name=>"admin/image_details",:menu_access=>"admin")
Menu.create(:parent_id=>asset_menu.id,:name=>"Gallery",:alias_name=>"gallery_list",:sequence_number=>2,:action_name=>"gallery_list",:controller_name=>"admin/image_details",:menu_access=>"admin")
Menu.create(:parent_id=>asset_menu.id,:name=>"Video",:alias_name=>"video_list",:sequence_number=>3,:action_name=>"media",:controller_name=>"admin/media_details",:menu_access=>"admin")
Menu.create(:parent_id=>asset_menu.id,:name=>"Audio",:alias_name=>"audio_list",:sequence_number=>4,:action_name=>"audio",:controller_name=>"admin/media_details",:menu_access=>"admin")
Menu.create(:parent_id=>asset_menu.id,:name=>"Digital Assets",:alias_name=>"digital_list",:sequence_number=>5,:action_name=>"index",:controller_name=>"admin/digital_assets",:menu_access=>"admin")

Menu.create(:parent_id=>0,:name=>"Home",:alias_name=>"home_menu",:sequence_number=>1,:action_name=>"admin_dashboard",:controller_name=>"admin/login", :menu_access=>"admin")

Menu.create(:parent_id=>0,:name=>"Menu",:alias_name=>"menu_list",:sequence_number=>2,:action_name=>"index",:controller_name=>"admin/menus",:menu_access=> "admin")

Menu.create(:parent_id=>0,:name=>"Taxonomy",:alias_name=>"category_menu",:sequence_number=>3,:action_name=>"index",:controller_name=>"admin/categories",  :menu_access=>"admin")

Menu.create(:parent_id=>0,:name=>"Data Listing",:alias_name=>"datalist_management",:sequence_number=>7,:action_name=>"index",:controller_name=>"admin/data_list",:menu_access=>"admin")

user_menu = Menu.create(:parent_id=>0,:name=>"Users",:alias_name=>"user_menu",:sequence_number=>8,:action_name=>"index",:controller_name=>"admin/users", :menu_access=> "admin")
Menu.create(:parent_id=>user_menu.id,:name=>"Sites",:alias_name=>"site_user_list_menu",:action_name=>"site_user_list",:controller_name=>"admin/users", :menu_access=>"admin")
Menu.create(:parent_id=>user_menu.id,:name=>"Roles",:alias_name=>"role_index_list",:action_name=>"index",:controller_name=>"admin/roles",:menu_access=> "admin")

pages_menu = Menu.create(:parent_id=>0,:name=>"Pages",:sequence_number=>9,:action_name=>"list_breadcrums",:controller_name=>"admin/page",:menu_access=> "admin")
Menu.create(:parent_id=>pages_menu.id,:name=>"Listing Page",:alias_name=>"page_management",:action_name=>"listing_page_list",:controller_name=>"admin/page",:menu_access=>"admin")
Menu.create(:parent_id=>pages_menu.id,:name=>"Page Property",:alias_name=>"pages_menu",:action_name=>"list_breadcrums",:controller_name=>"admin/page",:menu_access=>"admin")
Menu.create(:parent_id=>pages_menu.id,:name=>"Special Page",:alias_name=>"special_menu",:action_name=>"special_page_list",:controller_name =>"admin/page",:menu_access=>"admin")

Menu.create(:parent_id=>0,:name=>"Tags",:alias_name=>"tags_list",:sequence_number=>11,:action_name=>"index",:controller_name=>"admin/tags",:menu_access=> "admin")

Menu.create(:parent_id=>0,:name=>"Home",:alias_name=>"home_menu",:sequence_number=>1,:action_name=>"dashboard",:controller_name=>"admin/login",:menu_access=>"admin")

article_view_menu = Menu.create(:parent_id=>0,:name=>"Article View Management",:alias_name=>"question_list",:sequence_number=>13,:action_name=>"list_asset_group", :controller_name=>"list_asset_group",:menu_access=>"admin")
Menu.create(:parent_id=>article_view_menu.id,:name=>"Article Template Management",:alias_name=>"index_asset_group",:action_name=>"list_asset_group", :controller_name=>"admin/sites",:menu_access=>"admin")
Menu.create(:parent_id=>article_view_menu.id,:name=>"Article Layout Management",:alias_name=>"layout_menu",:action_name=>"index",:controller_name=>"admin/layout_managements",:menu_access=>"admin")

more_menu = Menu.create(:parent_id=>0,:name=>"More",:sequence_number=>30,:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Classified Listing",:alias_name=>"classified_listing_menu",:sequence_number=>1,:action_name=>"classified_list",:controller_name=>"admin/classified_listings", :menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Additional Data",:alias_name=>"AdditionalData",:sequence_number=>1,:action_name=>"index",:controller_name=> "admin/additional_data",:menu_access=>"admin")
form_menu = Menu.create(:parent_id=>more_menu.id,:name=>"Forms",:alias_name=>"0",:sequence_number=>2,:action_name=>"index",:controller_name=>"admin/questions", :menu_access=>"admin")
Menu.create(:parent_id=>form_menu.id,:name=>"Questionnaires",:alias_name=>"questionnaire_list",:sequence_number=>2,:action_name=>"index",:controller_name=>"admin/questionnaires",:menu_access=>"admin")
Menu.create(:parent_id=>form_menu.id,:name=>"Questions",:alias_name=>"question_list",:sequence_number=>1,:action_name=>"index",:controller_name=>"admin/questions",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Sites",:alias_name=>"site_index_menu",:sequence_number=>5,:action_name=>"index",:controller_name=>"admin/sites",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Newsletter",:alias_name=>"newsletter_menu",:sequence_number=>7,:action_name=>"newsletter",:controller_name=> "admin/articles",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Issue Management",:alias_name=>"print_management",:sequence_number=>8,:action_name=>"index", :controller_name=>"admin/print_management",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Interactive",:alias_name=>"poles_manager",:sequence_number=>8,:action_name=>"index",:controller_name=> "admin/polls",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Products",:alias_name=>"product_menu",:sequence_number=>10,:action_name=>"index",:controller_name=>"admin/products",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Site Accessories",:alias_name=>"site_accessories_menu",:sequence_number=>11,:action_name=>"site_properties", :controller_name=>"admin/sites",:menu_access=> "admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Image Size",:alias_name=>"image_size_list",:sequence_number=>16,:action_name=>"image_size_lists", :controller_name=>"admin/image_details",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Forum Management",:alias_name=>"forum_management",:sequence_number=>17,:action_name=>"index", :controller_name=>"admin/forum",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Product Criteria",:alias_name=>"product_management",:sequence_number=>18,:action_name=>"index", :controller_name=>"admin/product_criteria",:menu_access=>"admin")
Menu.create(:parent_id=>more_menu.id,:name=>"Asset Category",:alias_name=>"asset_category",:sequence_number=>19,:action_name=>"index",:controller_name=> "admin/asset_categories",:menu_access=>"admin")

directory_menu =Menu.create(:parent_id=>0,:name=>"Directory Listing",:alias_name=>"directory_listing_menu",:sequence_number=>7,:action_name=>"index",:controller_name=>"admin/directory_listings",:menu_access=>"admin")
Menu.create(:parent_id=>directory_menu.id,:name=>"Categories",:alias_name=>"directory_listing_category_menu",:sequence_number=>1,:action_name=>"index",:controller_name=> "admin/directory_listing_categories",:menu_access=>"admin")
Menu.create(:parent_id=>directory_menu.id,:name=>"Services",:alias_name=>"service_menu",:sequence_number=>2,:action_name=>"index",:controller_name=>"admin/services",:menu_access=>"admin")

Menu.create(:parent_id=>0,:name=>"Profile",:alias_name=>"author_list_menu",:sequence_number=>9,:action_name=>"index",:controller_name=>"admin/authors", :menu_access=>"admin")

Menu.create(:parent_id=>0,:name=>"Site Creation",:alias_name=>"site_creation_menu",:sequence_number=>6,:action_name=>"create_site",:controller_name=> "admin/sites",:menu_access=>"admin")

component_menu = Menu.create(:parent_id=>0,:name=>"Components",:alias_name=>"component_menu",:sequence_number=>10,:action_name=>"component_tree_view",:controller_name=> "admin/components",:menu_access=>"admin")
Menu.create(:parent_id=>component_menu.id,:name=>"Partials",:alias_name=>"partial_menu",:action_name=>"list_partials",:controller_name=>"admin/components",:menu_access=>"admin")
Menu.create(:parent_id=>component_menu.id,:name=>"Tree View",:alias_name=>"component_menu",:action_name=>"component_tree_view",:controller_name=> "admin/components",:menu_access=>"admin")
Menu.create(:parent_id=>component_menu.id,:name=>"Widget",:alias_name=>"widget_menu",:action_name=>"list_widget",:controller_name=>"admin/components",:menu_access=>"admin")

static_menu = Menu.create(:parent_id=>0,:name=>"Static",:alias_name=>"static_articles",:sequence_number=>5,:action_name=>"index",:controller_name=>"admin/static_page",:menu_access=>"admin")
Menu.create(:parent_id=>static_menu.id,:name=>"Static Page",:alias_name=>"static_articles",:action_name=>"index",:controller_name=>"admin/static_page",:menu_access=>"admin",:entity_type=> "static-page")
Menu.create(:parent_id=>static_menu.id,:name=>"Static Fragment",:alias_name=>"static_fragment",:action_name=>"index",:controller_name=>"admin/static_page",:menu_access=>"admin",:entity_type=> "static-fragment")
puts "*************Seeding Menu data end************"

puts "==================== seeding Role data start =============="
Role.create(:name=>"Author",:user_type=>"Author")
Role.create(:name=>"Content Admin",:user_type=>"Author")
Role.create(:name=>"Site Admin",:user_type=>"Admin")

puts "====================seeding role data end ==================="

puts "=============== Seeding Permission data start =================="
permission=Permission.create(:short_name=>"Site Modifier Dashboard",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Site Modifier Dashboard Management",:short_name=>"manage_site_modifier_dashboard")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Site",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Site Management",:short_name=>"site_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Menu",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Menu Management",:short_name=>"menu_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Taxonomy",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Taxonomy Management",:short_name=>"taxonomy_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Tag",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Tag Management",:short_name=>"tag_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Roles",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Role Management",:short_name=>"role_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Content",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Content",:short_name=>"manage_articles")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"User",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"User Management",:short_name=>"user_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Components",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Component Management",:short_name=>"component_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Authentication",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Authentication Management",:short_name=>"authentication_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Asset Category Management",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Asset Category Management Management",:short_name=>"place_poll")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Slide Show",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Slide Show",:short_name=>"manage_slideshow")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Content Modifier Dashboard",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Content Modifier Dashboard",:short_name=>"manage_content_modifier_dashboard")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Static Page Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Static Page Management",:short_name=>"static_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Author Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Author Management",:short_name=>"author_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Pic of the Day (INQ only)",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Pic of the Day (INQ only)",:short_name=>"manage_pic_of_the_day")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Images",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Images",:short_name=>"manage_images")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Media",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Media",:short_name=>"manage_media")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Polls",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Polls",:short_name=>"manage_poll")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Digital Assets",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Digital Assets",:short_name=>"manage_assets")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Comment Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Comment Management",:short_name=>"comment_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Directorylisting Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Directorylisting Management",:short_name=>"directory_listing_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Directorylisting Category Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"DirectorylistingCategory Management",:short_name=>"directory_categories_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Directorylisting Service Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Directorylisting Service Management",:short_name=>"services_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Newsletter Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Newsletter Management",:short_name=>"menu_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Admin Collection Management",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Admin Manage Ranked List",:short_name=>"admin_manage_ranklist")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Collection Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Collection Management",:short_name=>"admin_manage_ranklist")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Page Manager",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Page Management",:short_name=>"page_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Data Management",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Data Management",:short_name=>"datalist_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Blog Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Blog Management",:short_name=>"blog_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Event Management",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Event Management",:short_name=>"event_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Print Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Print Management",:short_name=>"print_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Export Management",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Export Management",:short_name=>"export_permission")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Import Management",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Import Management",:short_name=>"import_permission")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"User Information Management",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"User Setting",:short_name=>"user_self_setting")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Questionnaires",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Questionannaire",:short_name=>"questionnaires_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Questionnaires",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Questionannaire",:short_name=>"questionnaire_data_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end

permission=Permission.create(:short_name=>"Questionnaires",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Questionannaire",:short_name=>"questions_management")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end
permission=Permission.create(:short_name=>"User",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"User Management",:short_name=>"user_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end
permission=Permission.create(:short_name=>"Additional Data",:user_type=>"Author",
                             :sub_permissions=>[SubPermission.create(:name=>"Additional Data",:short_name=>"additional_data")])
Role.find_all_by_user_type("Author").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end
permission=Permission.create(:short_name=>"Authentication",:user_type=>"Admin",
                             :sub_permissions=>[SubPermission.create(:name=>"Product Criteria Management",:short_name=>"product_criteria_management")])
Role.find_all_by_user_type("Admin").each do |role_assignment|
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id}).flatten
  role_assignment.save
end
puts "=============== Seeding Permission data end =================="

puts "=============== Seeding site data start ======================="
presentation_proxy = PresentationProxy.create()
data_proxy = DataProxy.create()
site=Site.create(:name=>"worldwidemedia.kreatio.com",:short_name=>"world_wide_media",:layout_path=>"/layouts/world_wide_media",:presentation_proxy_id=>presentation_proxy.id ,:data_proxy_id=>data_proxy.id ,:url_display_name=>"worldwidemedia.kreatio.com",:active=>true,:status=>"Online",:domain=>"worldwidemedia.kreatio.com", :site_type=>"Site",:module_type=>"main_site")
puts "================ Seeding Site data end =========================="

puts "================ Seeding User data start ========================="
roles = Role.find(:all,:conditions=>["name = ?","Content Admin"]) + Role.find(:all,:conditions=>["name = ?","Site Admin"])
Ambient.init()
Ambient.current_site=site
[{:firstname=>"Prabu",:lastname=>"G",:email=>"gprabhu@kreatio.com"},{:firstname=>"qa",:lastname=>"kreatio",:email=>"qa@kreatio.com"},{:firstname=>"core",:lastname=>"kreatio",:email=>"core@kreatio.com"},{:firstname=>"infrastructure",:lastname=>"kreatio",:email=>"infrastructure@kreatio.com"},{:firstname=>"swapnil",:lastname=>"shilpa",:email=>"swapnil@kreatio.com"},{:firstname=>"senthil",:lastname=>"kumar",:email=>"senthil@kreatio.com"}].each do |new_user|
  user = User.find(:first,:conditions=>["UPPER(email) = ?",new_user[:email].strip.upcase])
  if user.blank?
    user = User.create(:entity_id => 1 , :entity_type => "Author", :firstname => new_user[:firstname], :lastname => new_user[:lastname] ,:password => Digest::MD5.hexdigest("!#{new_user[:firstname]}$%") ,:email => "#{new_user[:email]}" ,:final_selected_site_id => site.id)
  end
  author=Author.create(:firstname=>user.firstname,:lastname=>user.lastname,:email=>user.email,:sites=>[site],:user_id=>user.id)
  user.update_attributes(:entity_id=>author.id) unless author.errors.blank?
  roles.each do |role|
    if SiteUserRole.where(:site_id => site.id).where(:user_id=>user.id).where(:role_id => role.id).blank?
      SiteUserRole.create(:user_id=> user.id,:role_id=> role.id,:site_id=> site.id)
    end
  end
end
puts "================ Seeding User data end ========================="
