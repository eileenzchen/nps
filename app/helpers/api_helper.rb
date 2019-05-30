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
    puts BASE_URL+cond+API_KEY
    request = HTTP.get(BASE_URL+cond+API_KEY)
    request_json = JSON.parse(request)
    return request_json
  end






end
