require_relative 'traductor'
require_relative 'rest_client'

traductor = Traductor.new
rest_client = RestClient.new


ARGV.each do |english_name|
  traduction = traductor.eglish_to_klingon(english_name)
  if traduction
    p traduction
    character = rest_client.get_character_by_name(english_name)['characters']

    if character != []
      udid = character[0]['uid']
    else
      p 'Caracter does not exits'
    end

    if udid
      character = rest_client.get_character_by_uid(udid)['character']['characterSpecies'][0]
      if character
        p character['name']
      else
        p 'Species not determined'
      end
    end
  else
    p 'Not translatable Name'
  end
end

