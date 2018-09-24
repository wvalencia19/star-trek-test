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
    response = self.class.post("/search", options)
    return nil unless response.code == 200
    return response['characters']
  end

  def get_character_by_uid(uid)
    options = {query: {uid: uid}}
    response = self.class.get("/", options)
    return nil unless response.code == 200
    return response['character']['characterSpecies'][0]
  end
end