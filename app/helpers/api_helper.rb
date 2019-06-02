require "json"
require "http"

module ApiHelper

  # example get request url
  # https://developer.nps.gov/api/v1/parks?parkCode=acad&api_key=AfKfqBbdNqy99Ftuu7J732X9aeTcba8AEQGPyzKJ
  # obj = HTTP.get("https://developer.nps.gov/api/v1/parks?parkCode=acad&api_key=AfKfqBbdNqy99Ftuu7J732X9aeTcba8AEQGPyzKJ")
  # parsed = JSON.parse(obj)

  API_KEY = "api_key=AfKfqBbdNqy99Ftuu7J732X9aeTcba8AEQGPyzKJ"

  BASE_URL = "https://developer.nps.gov/api/v1"

  # keyword search
  def keyword_query(cond)
    request = HTTP.get(BASE_URL+cond+API_KEY)

    request_json = JSON.parse(request)

    return request_json
  end

  GOOGLE_URL = "https://www.googleapis.com/customsearch/v1"
  GOOGLE_KEY = "key=AIzaSyBfu5Ac_oAJ8qjUgRWutuA3OHzAnyg1hpM"
  CX = "&cx=009223487904851613558:zwhhyb4vkte"

  # https://www.googleapis.com/customsearch/v1?q=Acadia%20National%20Park&searchType=image&key=AIzaSyBfu5Ac_oAJ8qjUgRWutuA3OHzAnyg1hpM&cx=009223487904851613558:zwhhyb4vkte

  def google_image(park)
    url = URI::escape(GOOGLE_URL+"?q="+park+"&num=1&searchType=image&"+GOOGLE_KEY+CX)
    request = HTTP.get(url)
    request_json = JSON.parse(request)
    unless !request_json["error"].nil?
      image = request_json["items"][0]["link"]
      return image
    end
    return nil
  end





end
