class ParksController < ApplicationController
  include ApiHelper

  def show
    @park_code = params[:park_code]
    @park = keyword_query("/parks?parkCode=#{@park_code}&")["data"][0]
    @alerts = keyword_query("/alerts?parkCode=#{@park_code}&")["data"]
    @alerts_closure = @alerts.select{|alert| alert["category"] == "Park Closure"}
    @alerts_danger = @alerts.select{|alert| alert["category"] == "Danger"}
    @alerts_caution= @alerts.select{|alert| alert["category"] == "Caution"}
    @alerts_info = @alerts.select{|alert| alert["category"] == "Information"}
    @articles = keyword_query("/articles?parkCode=#{@park_code}&")["data"]
    @articles = @articles.select{|article| article["listingimage"]["url"] != "" && article["url"] != ""}.take(5)
    @events = keyword_query("/events?parkCode=#{@park_code}&")["data"]
    @news_releases = keyword_query("/newsreleases?parkCode=#{@park_code}&")["data"]
    @news_releases = @news_releases.select{|nr| nr["image"]["url"] != "" && nr["url"] != ""}.take(5)
    
  end

end
