#require 'ruby-debug'
#load all component file
if IS_ADMIN
  puts "==================================Component Start loading Time => #{Time.sr_now} ==============================="
  #component_path="#{Rails.root}/../core/app/components"

  component_path="#{Rails.root}/../Kreatio_Core/app/components"
  require "#{Rails.root}/app/components/00_base.rb"
  if File.exists?(component_path)
    Dir.entries(component_path).grep(/.rb$/).sort.collect do |file_name|
      File.open(File.join(component_path,file_name)) do |file|

        puts "================================== Start file #{file_name} => Time => #{Time.sr_now} ======================"

        require file
        puts "================================== End file #{file_name} => Time => #{Time.sr_now}=========================="

      end
    end
  end
  puts "==================================End loading Time =#{Time.sr_now}============================================="
  COMPONENT_ARGUMENT_HASHES=SrComponent.component_argument_hashes
else
  #require "#{Rails.root}/app/components/01_site_specific_component.rb"
  #This constant contain all the component hash values
  COMPONENT_ARGUMENT_HASHES=SrComponent.component_argument_hashes

end
