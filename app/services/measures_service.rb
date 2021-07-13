class MeasuresService
  KEYWORDS = {
    'Kilo': %w(kg kilo kilos k),
    'Gramo': %w(gr gramo gramos g),
    'Litro': %w(l litro litros lt),
    'Mililitro': %w(ml mililitro mililitros mls milis),
    'Unidad': %w(u unidad unidades un)
  }

  def self.map_measure(measure)
    KEYWORDS.each_pair do |keyword, values|
      return keyword.to_s if values.include?(measure.downcase)
    end

    measure
  end
end
