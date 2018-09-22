require_relative 'rest_client'

class Character
  def get_by_name(english_name, requester)
    character = requester.get_character_by_name(english_name)['characters']
    return character[0]['uid'] if character != []
  end

  def get_specie_by_uid(uid, requester)
    response = requester.get_character_by_uid(uid)
    character = response['character']['characterSpecies'][0]
    return character['name'] if character
  end
end
