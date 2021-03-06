class ParksController < ApplicationController
  require 'date'


  include ApiHelper

  def show
    
    @park_code = params[:park_code]
    if @park_code.nil?
      @park_code = params[:parkCode]
    end
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

    @visitor_centers = keyword_query("/visitorcenters?parkCode=#{@park_code}&")["data"]

    @campgrounds = keyword_query("/campgrounds?parkCode=#{@park_code}&")["data"]
    
  end

  def learn
    @park_code = params[:park_code]
    if @park_code.nil?
      @park_code = params[:parkCode]
    end
    @park = keyword_query("/parks?parkCode=#{@park_code}&")["data"][0]
    @lesson_plans = keyword_query("/lessonplans?parkCode=#{@park_code}&")["data"]
    @people = keyword_query("/people?parkCode=#{@park_code}&")["data"]
    @places = keyword_query("/places?parkCode=#{@park_code}&")["data"]
  end

end
