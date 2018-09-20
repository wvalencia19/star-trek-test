require_relative 'constants'

class Traductor
  def eglish_to_klingon(name)
    response = ''
    word_origin = name
    word_lower = name.downcase
    word_size = name.size
    i = 0
    while i < word_size do
      found = false
      GlobalConstants::KLINGON_ALPHABET.each do |letter, v|
        unless letter.downcase == 'q'
          word = word_lower
        else
          word = word_origin
        end
        if word[i,word_size].index(letter) == 0
          response << "#{v} "
          i += (letter.size)
          found = true
          break
        end
      end
      return 'Not found' unless found
    end
    return response.chomp(' ')
  end
end
