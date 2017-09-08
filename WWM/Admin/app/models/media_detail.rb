class MediaDetail < ActiveRecord::Base

  def self.common_transaction(original_filename,site,file_type,tmp_path)
    MediaDetail.transaction do
      media = MediaDetail.new(:site_id=>site.id,:original_file_name=>original_filename,:name=>original_filename.gsub(' ','_').split('.')[0])
      if media.save
        media.update_attributes(:video_path=>"/medias/"+media.id.to_s+"/"+original_filename,:display_name=>media.name)
        FileUtils.mkdir_p  "public/medias/#{media.id.to_s}" ,:mode => 0777
        FileUtils.mkdir_p  "#{Rails.root}/tmp/media_conversion/#{media.id.to_s}" ,:mode => 0777
        output_path = "#{Rails.root}/tmp/media_conversion/#{media.id.to_s}"
        flv_filename = original_filename
        p="#{Rails.root}/tmp/media_files/#{original_filename}"
        FileUtils.mv tmp_path,output_path # if file_type=~/(.*?)\.(flv)$/i
        flv_file_path = "#{output_path}/#{flv_filename}"
        FileUtils.mkdir_p  "public/medias/#{media.id.to_s}/thumbs" ,:mode => 0777
        FileUtils.mkdir_p  "#{output_path}/thumbs"
        thumb_path="#{output_path}/thumbs"
        meta_info = MediaManager.get_meta_info(output_path,flv_filename)
        file_size = File.size(flv_file_path)
        image_path = "/medias/#{media.id.to_s}/thumbs"
        videopath = media.video_path
        dir=Dir.open("#{thumb_path}")
        image_list =  dir.collect {|filename| filename if (filename!="." and filename!="..")}
        default_image_path = "#{image_path}/#{image_list.first}"
        media.update_attributes(:file_size=>file_size,:video_duration=>meta_info.to_s,:image_path=>default_image_path)
        copy_videos(media.id,flv_filename)
        v_path = "#{Rails.root}/public/medias/#{media.id.to_s}/"
        o_file = "#{Rails.root}/public#{media.video_path}"
      status=true
      return media,status
      end
    end
  end

end
