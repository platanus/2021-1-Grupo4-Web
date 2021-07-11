require 'rails_helper'

RSpec.describe MeasuresService do
  def run(scraped_measure)
    MeasuresService.map_measure(scraped_measure)
  end

  describe 'map all the measures correctly' do
    it 'returns correctly the mapped measures when exist' do
      expect(run('l')).to eq('Litro')
      expect(run('UNIDADES')).to eq('Unidad')
      expect(run('kilo')).to eq('Kilo')
    end

    it 'does not map measures that does not exist' do
      expect(run('lámina')).to eq('lámina')
    end
  end
end
