class DigitalAsset < ActiveRecord::Base
    belongs_to :magazine_issue
    
 def self.save_asset_in_file_system(uploaded_file,docment_details,get_doc=nil)
    folder_path=docment_details.protected ? "protected/digital_assets/#{docment_details.id}" : "public/digital_assets/#{docment_details.id}"
    FileUtils.mkdir_p folder_path,:mode => 0777    
    nginx_file =(uploaded_file[".path"])
    uploaded_file_name = uploaded_file[".name"]
    text = "#{Rails.root}"+"/#{folder_path}/#{uploaded_file_name}"
    org_file_name = (nginx_file.split('/').last) 
    logger.info "=======save_asset_in_file_system===============#{org_file_name}==#{uploaded_file_name}==#{folder_path}==#{text}=="
    FileUtils.mv "#{nginx_file}","#{Rails.root}/#{folder_path}"
    logger.info "=======save_asset_in_file_system=============#{Rails.root}"+"/#{folder_path}/#{org_file_name}===#{Rails.root}"+"/#{folder_path}/#{docment_details.name}================"
    File.rename("#{Rails.root}"+"/#{folder_path}/#{org_file_name}", "#{Rails.root}"+"/#{folder_path}/#{docment_details.name}")   
#    File.open("#{Rails.root}"+"/#{folder_path}/#{docment_details.name}", "wb") { |f| f.write("#{Rails.root}"+"/#{folder_path}/"+"#{org_file_name}")}
    file_path = File.join(folder_path,docment_details.name)   
#    FileUtils.cp uploaded_file.path, file_path
    FileUtils.chmod 0777, file_path
    saving_path=docment_details.protected ? "protected/digital_assets/#{docment_details.id}" : "/digital_assets/#{docment_details.id}" 
    docment_details.update_attributes(:document_path=>"#{saving_path}/#{docment_details.name}",:file_size=>File.size("#{folder_path}/#{docment_details.name}"))     
    return docment_details if get_doc and docment_details 
  end

  def self.save_asset(site,parameters,get_doc=nil )
    DigitalAsset.transaction do
      if not parameters["document_path"].blank?
        tmp_file = parameters["document_path"] 
        uploaded_file = parameters.delete(:document_path)
        docment_details=site.digital_assets.new(parameters)
        logger.info "=======save_asset_in_file_system=============#{tmp_file.inspect}=="
        docment_details.name = tmp_file[".name"].gsub(" ","-")
        docment_details.document_path = docment_details.protected ? "/protected/digital_assets/#{docment_details.id}" : "/digital_assets/#{docment_details.id}"
        docment_details.save
        save_asset_in_file_system(tmp_file,docment_details,get_doc)
      end
    end
  end

end
