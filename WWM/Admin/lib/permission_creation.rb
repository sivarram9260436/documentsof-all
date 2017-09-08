permission=Permission.create(:short_name=>"Newsletter Management",:user_type=>"Author",
                  :sub_permissions=>[SubPermission.create(:name=>"Newsletter Management",:short_name=>"newsletter_management")])
role_assignments=Role.all
for role_assignment in role_assignments
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
  role_assignment.save
end

permission=Permission.create(:short_name=>"Rae Management",:user_type=>"Author",
                  :sub_permissions=>[SubPermission.create(:name=>"Rae Management",:short_name=>"rae_management")])
role_assignments=Role.all
for role_assignment in role_assignments
  role_assignment.permission_ids = (role_assignment.permission_ids << permission.id)
  role_assignment.sub_permission_ids = (role_assignment.sub_permission_ids << permission.sub_permissions.collect{|a| a.id})
  role_assignment.save
end