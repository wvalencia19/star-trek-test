require_relative 'traductor'
require_relative 'rest_client'
require_relative 'character'

traductor = Traductor.new
rest_client = RestClient.new
character = Character.new


ARGV.each do |english_name|
  traduction = traductor.eglish_to_klingon(english_name)
  if traduction
    p traduction
    uid = character.get_by_name(english_name, rest_client)
    if uid
      specie = character.get_specie_by_uid(uid, rest_client)
      if specie
        p specie
      else
        p 'Specie not determined'
      end
    else
      p 'Caracter does not exits'
    end
  else
    p 'Not translatable Name'
  end
end

