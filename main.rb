require_relative 'traductor'
require_relative 'rest_client'
require_relative 'character'
require 'redis'

traductor = Traductor.new
rest_client = RestClient.new
character = Character.new
redis = Redis.new


ARGV.each do |english_name|
  character_data = redis.hmget(english_name, 'traduction', 'specie')
  if character_data[0]
    p character_data[0]
    p character_data[1]
  else
    traduction = traductor.eglish_to_klingon(english_name)
    if traduction
      p traduction
      uid = character.get_by_name(english_name, rest_client)
      if uid
        specie = character.get_specie_by_uid(uid, rest_client)
        if specie
          p specie
        else
          specie = 'Specie not determined'
          p specie
        end
      else
        p 'Caracter does not exits'
      end
      redis.hmset(english_name, 'traduction',traduction, 'specie', specie)
    else
      p 'Not translatable Name'
    end
  end
end

