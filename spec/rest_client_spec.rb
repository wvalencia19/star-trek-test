require_relative '../rest_client'
require 'spec_helper'
require 'vcr'

describe 'Test rest client' do
  context 'when get character by english name' do
    it 'returns uid' do
      VCR.use_cassette('correct_result') do
        rest_client = RestClient.new
        res = rest_client.get_character_by_name("Or'Eq")
        expect(res[0]).to include('uid')
      end
    end
  end

  context 'when get character by uid' do
    it 'returns name' do
      VCR.use_cassette('correct_result', :record => :new_episodes) do
        rest_client = RestClient.new
        res = rest_client.get_character_by_uid('CHMA0000226446')
        expect(res).to include('name')
      end
    end
  end
end

