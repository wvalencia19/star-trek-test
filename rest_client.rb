require 'httparty'

class RestClient
  SERVER_HOST = 'http://stapi.co/api/v1/rest/character'
  include HTTParty
  base_uri SERVER_HOST

  def get_character_by_name(name)
    headers = {
        'Content-Type' => 'application/x-www-form-urlencoded'
    }
    options = {query: {name: name}, headers: headers}

    self.class.post("/search", options)
  end

  def get_character_by_uid(uid)
    options = {query: {uid: uid}}

    self.class.get("/", options)
  end
end