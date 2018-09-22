require_relative 'traductor'
require 'redis'

class Character
  def initialize(resource)
    @resource = resource
  end

  def process_name(english_name)
    traductor = Traductor.new
    redis = Redis.new
    response = {}
    character_data = redis.hmget(english_name, 'traduction', 'specie')
    if character_data[0]
      response[:traduction] = character_data[0]
      response[:specie] = character_data[1]
      return response
    else
      traduction = traductor.eglish_to_klingon(english_name)
      if traduction
        response[:traduction] = traduction
        uid = character.get_by_name(english_name)
        if uid
          specie = character.get_specie_by_uid(uid)
        else
          response[:specie] = 'Character does not exits'
        end
        redis.hmset(english_name, 'traduction',traduction, 'specie', specie)
        return response
      end
    end
  end

  private
  def get_by_name(english_name)
    character = @resource.get_character_by_name(english_name)['characters']
    return character[0]['uid'] if character != []
  end

  def get_specie_by_uid(uid)
    response = @resource.get_character_by_uid(uid)
    character = response['character']['characterSpecies'][0]
    specie = character['name']
    return specie ? specie : 'Specie not determined'
  end
end
