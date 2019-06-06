class ParksController < ApplicationController
  require 'date'


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
    @articles = @articles.select{|article| article["listingimage"]["url"] != "" && article["url"] != ""}.take(3)
    @events = keyword_query("/events?parkCode=#{@park_code}&pagesize=50&")["data"].select{|event| event["title"] != ""}
    @events_reformatted = []
    
    @events.each do |event| 

  
      if event["isrecurring"] == "true" 
        arr = {}
        arr["title"] = event["title"]
        arr["start"] = event["datestart"]
        arr["end"] = event["recurrencedateend"]
        arr["location"] = event["location"]
        arr["times"] = event["times"]
        arr["description"] = event["description"]
        arr["allDay"] = event["isallday"]

        @events_reformatted.push(arr)
      
      
      else
        event["dates"].each do |date|
          arr = {}
          arr["title"] = event["title"]
          arr["start"] = date
          arr["end"] = date
          arr["location"] = event["location"]
          arr["times"] = event["times"]
          arr["description"] = event["description"]
          arr["allDay"] = event["isallday"]
          @events_reformatted.push(arr)
        end
      end
      
    end


    @news_releases = keyword_query("/newsreleases?parkCode=#{@park_code}&")["data"]
    @news_releases = @news_releases.select{|nr| nr["image"]["url"] != "" && nr["url"] != ""}.take(3)
    
  end

end
