require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:recipe_ingredient) { build(:recipe_ingredient) }

  it { is_expected.to belong_to(:recipe) }
  it { is_expected.to belong_to(:ingredient) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(recipe_ingredient.attributes).to include("id")
    end

    it "includes the :ingredient_quantity attribute" do
      expect(recipe_ingredient.attributes).to include("ingredient_quantity")
    end
  end
end
