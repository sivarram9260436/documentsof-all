class Article
  def get_related_articles(site,number_of_results,primary_medium,filters={})
    self.related_articles(site,number_of_results,"Relevance",filters).results.select {|n| n.primary_medium ==primary_medium}
  end

  def average_rating
    self.ratings.collect(&:rate).inject(:+).to_f/self.ratings.size rescue 0
  end

  def star_color
    average_rating.round(2) * 18
  end

end
