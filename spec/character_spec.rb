require_relative '../character'
require_relative '../rest_client'
require 'fake_redis'

describe 'Test process name' do
  before do
    @rest_client = RestClient.new
    @redis = Redis.new
    @character = Character.new(@rest_client, @redis)
    @uid = 'CHMA0000226446'
    @specie = 'Klingon'
    @english_name = "Or'Eq"
    @traduction = '0xF8DD 0xF8E1 0xF8E9 0xF8D4 0xF8DF'
    @redis.flushall
  end

  context 'when english name does not exist in redis' do
    it 'get data from external resources' do
      expect(@character).to receive(:get_by_name)
                                .once.and_return(@uid)
      expect(@character).to receive(:get_specie_by_uid)
                                   .once.and_return(@specie)
      expect(@redis).to receive(:hmset).once

      result = @character.process_name(@english_name)

      expect(result[:specie]).to eq @specie
      expect(result[:traduction]).to eq @traduction
    end
  end

  context 'when english name exits' do
    it 'get data from redis' do
      redis_response = [@traduction, @specie]
      expect(@redis).to receive(:hmget)
                            .once.and_return(redis_response)
      expect(@redis).not_to receive(:hmset)
      expect(@character).not_to receive(:get_by_name)
      expect(@character).not_to receive(:get_specie_by_uid)
      test = @character.process_name(@english_name)

      expect(test[:traduction]).to eq @traduction
      expect(test[:specie]).to eq @specie
    end
  end
end
