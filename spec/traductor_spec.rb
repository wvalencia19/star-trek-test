require_relative '../traductor'

describe "Test traduction process" do
  before do
    @traductor = Traductor.new
    @tests = {
        uhura: '0xF8E5 0xF8D6 0xF8E5 0xF8E1 0xF8D0',
        "Or'Eq" => '0xF8DD 0xF8E1 0xF8E9 0xF8D4 0xF8DF',
        q: GlobalConstants::KLINGON_ALPHABET['q'],
        Q: GlobalConstants::KLINGON_ALPHABET['Q'],
        'Ned Quint' => '0xF8DB 0xF8D4 0xF8D3 0x0020 0xF8E0 0xF8E5 0xF8D7 0xF8DB 0xF8E3',
        'M. Nyquis' => '0xF8DA 0xF8FE 0x0020 0xF8DB 0xF8E8 0xF8DF 0xF8E5 0xF8D7 0xF8E2',
    }

  end

  context 'when is a normal english word' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon('uhura')
      expect(traduction).to eq @tests[:uhura]
    end
  end

  context 'when is a word with cognate letter' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon('Uhura')
      expect(traduction).to eq @tests[:uhura]
    end
  end

  context 'when is a word with special character' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon("Or'Eq")
      expect(traduction).to eq @tests["Or'Eq"]
    end
  end

  context 'when is a word with Q' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon("Q")
      expect(traduction).to eq @tests[:Q]
      expect(traduction).not_to eq @tests[:q]
    end
  end

  context 'when is a word with q' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon("q")
      expect(traduction).to eq @tests[:q]
      expect(traduction).not_to eq @tests[:Q]
    end
  end

  context 'when is a word with space' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon('Ned Quint')
      expect(traduction).to eq @tests['Ned Quint']
    end
  end

  context 'when is a word with space and special character' do
    it 'correct traduction' do
      traduction = @traductor.eglish_to_klingon('M. Nyquis')
      expect(traduction).to eq @tests['M. Nyquis']
    end
  end

  context 'when is a word with unknown letter' do
    it 'returs error' do
      traduction = @traductor.eglish_to_klingon('Uhurak')
      expect(traduction).to be_nil
    end
  end
end
