require_relative 'character'
require_relative 'rest_client'

rest_client = RestClient.new
character = Character.new(rest_client)

ARGV.each do |english_name|
  response = character.process_name(english_name)
  if response
    p response[:traduction]
    p response[:specie]
  else
    p 'Not translatable Name'
  end
end


