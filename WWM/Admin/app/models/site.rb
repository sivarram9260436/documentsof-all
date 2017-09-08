class Site < ActiveRecord::Base
  has_many :newsletter_registerations

  def issues_by_year(args={})
    source=self.sources.first
    latest_magazine_year = self.magazine_issues.sort_by{|aa| aa.date_of_publication}.last.date_of_publication.strftime("%Y") if self.magazine_issues
    year = args["year"].blank? ? (latest_magazine_year) : args["year"]
    magazines = source.magazine_issues.by_year(year.to_i,source.id)
    return magazines
  end

 def google_new_sitemap_page
  "/listing_pages/news-sitemap"    
  end
  
  def google_sitemap_index_page
  "/listing_pages/sitemap_index" 
  end   

  def google_videositemap_page
  "/listing_pages/videositemap"    
  end
 
 def get_sitemap_page
  "/listing_pages/sitemap.xml.builder"    
  end
  

end
