include ApplicationHelper
class ArticleContent < ActiveRecord::Base

 def new_image_library_tag(id,html_attributes,logical_name="default")
    if Image.exists?(id)
      image = Image.find(id)
      check_width=html_attributes.match(/.*width\=\"(\d+)\"\s.*/)
        if check_width!=nil
        wd=$1
        else
        wd=0
        end
      check_height=html_attributes.match(/.*height\=\"(\d+)\"\s.*/)
        if check_width!=nil
        ht=$1
        else
        ht=0
        end
      img=image.resized_image(wd.to_s,ht.to_s)
      if img!=nil
        img_path=img.image_path
      else
        img_path=image.image_path
      end
        check_alt_tag=html_attributes.match(/alt=['|"]([^"]*)['|"]/i)
       if check_alt_tag!=nil
        alt=$1
      end
      html_attributes=html_attributes.sub(/alt=['|"]([^"]*)['|"]/i,"")
      # (Util.new.image_tag(img_path,:border=>0,:alt=>alt).split("/>")[0])+(html_attributes.html_safe)+"/>".html_safe     
        (Util.new.image_tag(img_path,:border=>0,:alt=>alt.gsub("@@@",",")).split("/>")[0])+(html_attributes.gsub('"',"'").gsub("&quot",'').gsub('\;','').html_safe.gsub("@@@",","))+"/>".html_safe
      #     "<img #{alt} src='#{image.image_path}' #{html_attributes} />" 
    else
     " "
    end
  end




#  #new structure of image folder IMG/123/213123/wqew.jpg
#  def replace_new_content_image_new(content)
#     content.gsub(/\[image_library_tag \d+\/\d+,[^,|\]]*,[^,|\]]*\]/) do |img_tag|
#      img_tag=~/\[image_library_tag \d+\/(\d+),([^,|\]]*),([^,|\]]*)\]/
#      new_image_library_tag_temp($1,$2,$3)
#    end
#  end


#  def content_with_asset
#    content_with_image=replace_content_image(self.content) if self.content
#    content_asset=replace_content_asset(content_with_image) if content_with_image
#    replace_new_content_image_new(content_asset) if content_asset
#  end


def self.replace_image(content)
   # content
   content.gsub(/(<img[^>]*src=['|"][^'|"]*\/img\/\d+\/[^'|"]*['|"][^>]*\/>)/i) do |img_tag|
      img_tag=~/<img([^>]*)src=['|"][^'|"]*\/img\/([\d|\/]+)\/[^'|"]*['|"]([^>]*)\/>/i
      if $2
       title = $1
       alt = $3
#       "[image_library_tag #{$2},#{$1} #{$3},default]"     
        "[image_library_tag #{$2},#{title.gsub(",","@@@")} #{alt.gsub(",","@@@").gsub('"',"'").gsub("&quot",'').gsub('\;','')},default]"
      end
    end
  end

  #new structure of image folder IMG/123/213123/wqew.jpg
  def replace_new_content_image(content)
     content.gsub(/\[image_library_tag \d+\/\d+,[^,|\]]*,[^,|\]]*\]/) do |img_tag|
      img_tag=~/\[image_library_tag \d+\/(\d+),([^,|\]]*),([^,|\]]*)\]/
      new_image_library_tag($1,$2,$3)
    end
  end

  #This method used to get the splitted content from DB to Hash.
  def get_pages_for_article
      content=self.content_with_asset
      if self.has_pages? # Need to generate Array of Hash=>[{"title"=>"t1", "content"=>"<p>c1</p>"},{"title"=>"t2", "content"=>"<p>c2</p>"}]       
        content_array=[]
        pages=content.split(PAGE_BREAK)
        pages.each {|each_page|
         title,content=get_title_and_content(each_page)
         content_array << {"title"=>title,"content"=>content}
        }
       content_array
      else
       return [{"title"=>self.title,"content"=>content}]
      end
  end
  

  before_save do | article_content |
    article_content.content = ArticleContent.replace_image(article_content.content)  if  article_content.content
    article_content.content = ArticleContent.replace_asset(article_content.content)  if  article_content.content
    article_content.extended_body = ArticleContent.replace_image(article_content.extended_body)  if  article_content.extended_body
    article_content.extended_body = ArticleContent.replace_asset(article_content.extended_body)  if  article_content.extended_body
#    article_content.publish_date = article_content.article.publish_date 
#    article_content.display_date = article_content.article.display_date  
#    article_content.expiry_date = article_content.article.expiry_date    
   article_content.meta_keywords=(article_content.tags.collect{|tag| tag.name} + (article_content.categories.collect{|category| category.full_alias_name.split(">>")}).uniq).join(",") if article_content.meta_keywords.blank?
    article_content.meta_description= "#{article_content.sub_title} #{article_content.description}" if article_content.meta_description.blank?
    article_content.url_part = Util.convert_to_url_string_with_option(article_content.title,{:remove_stop_words=>true}) if article_content.article.published_version_id.blank? and not article_content.title.blank?
    article_content.text_for_highlighting = Util.highlighted_summary_text(article_content)
  #  article_content.content=self.page_break_content(article_content.content) if  article_content.content 
  end

  
end

