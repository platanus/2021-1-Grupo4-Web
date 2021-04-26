require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { build(:ingredient) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:provider).optional }
  it { is_expected.to have_many(:recipe_ingredients) }
  it { is_expected.to have_many(:recipes).through(:recipe_ingredients) }

  describe 'it has all the attributes' do
    ["name", "sku", "price", "currency", "quantity", "measure"].each do |attribute|
      it "includes the #{attribute} attribute" do
        expect(ingredient.attributes).to include(attribute)
      end
    end
  end
end
