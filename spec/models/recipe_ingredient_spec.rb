require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  describe RecipeIngredient do
    subject(:recipe_ingredient) { build(:recipe_ingredient) }
    it { is_expected.to belong_to(:recipe) }
  end
  describe RecipeIngredient do
    subject(:recipe_ingredient) { build(:recipe_ingredient) }
    it { is_expected.to belong_to(:ingredient) }
  end
  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(subject.attributes).to include("id")
    end
    it "includes the :ingredient_quantity attribute" do
      expect(subject.attributes).to include("ingredient_quantity")
    end
  end
end
