require_relative 'traductor'
require_relative 'constants'

class Character
  def initialize(resource, cache)
    @resource = resource
    @cache = cache
  end

  def process_name(english_name)
    traductor = Traductor.new
    response = {}
    character_data = @cache.hmget(english_name, 'traduction', 'specie')
    if character_data[0]
      response[:traduction] = character_data[0]
      response[:specie] = character_data[1]
      return response
    else
      traduction = traductor.eglish_to_klingon(english_name)
      if traduction
        response[:traduction] = traduction
        uid = get_by_name(english_name)
        if uid
          response[:specie] = get_specie_by_uid(uid)
        else
          response[:specie] = GlobalConstants::CHARACTER_NOT_EXITS
        end
        @cache.hmset(english_name, 'traduction',traduction, 'specie', response[:specie])
        @cache.expire(english_name, 691200)
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
    specie = character['name'] if character
    return specie ? specie : GlobalConstants::SPECIE_NOT_DETERMINED
  end
end
