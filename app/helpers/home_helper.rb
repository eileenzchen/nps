require "json"
require "http"

module HomeHelper

  # example get request url
  # https://developer.nps.gov/api/v1/parks?parkCode=acad&api_key=AfKfqBbdNqy99Ftuu7J732X9aeTcba8AEQGPyzKJ
  # obj = HTTP.get(https://developer.nps.gov/api/v1/parks?parkCode=acad&api_key=AfKfqBbdNqy99Ftuu7J732X9aeTcba8AEQGPyzKJ)
  # parsed = JSON.parse(obj)

  API_KEY = "AfKfqBbdNqy99Ftuu7J732X9aeTcba8AEQGPyzKJ"

  API_HOST = "https://developer.nps.gov/api/v1"
  


end
