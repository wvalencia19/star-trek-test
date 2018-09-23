require_relative 'character'
require_relative 'rest_client'
require_relative 'constants'
require 'redis'

rest_client = RestClient.new
redis = Redis.new
character = Character.new(rest_client, redis)

ARGV.each do |english_name|
  response = character.process_name(english_name)
  if response
    p response[:traduction]
    p response[:specie]
  else
    p GlobalConstants::NOT_TRANSLATABLE_NAME
  end
end


