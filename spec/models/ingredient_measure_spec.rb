require 'rails_helper'

RSpec.describe IngredientMeasure, type: :model do
  let(:ingredient_measure) { build(:ingredient_measure) }

  it { is_expected.to belong_to(:ingredient) }

  describe 'it has all the attributes' do
    ["name", "quantity"].each do |attribute|
      it "includes the #{attribute} attribute" do
        expect(ingredient_measure.attributes).to include(attribute)
      end
    end

    it "succeeds on save" do
      expect(ingredient_measure.save!).to be(true)
    end
  end

  describe "without ingredient" do
    let(:ingredient_measure) { build(:ingredient_measure, ingredient: nil) }

    it "raises RecordInvalid exception" do
      expect { ingredient_measure.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
