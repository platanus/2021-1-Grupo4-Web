require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:user){ create(:user) }
  let(:recipe_ingredient) { build(:recipe_ingredient, ingredient: create(:ingredient, user: user), recipe: create(:recipe, user: user)) }

  it { is_expected.to belong_to(:recipe) }
  it { is_expected.to belong_to(:ingredient) }

  describe 'it has all the attributes' do
    it "includes the :ingredient_quantity attribute" do
      expect(recipe_ingredient.attributes).to include("ingredient_quantity")
    end
    it "succeeds on save" do
      expect(recipe_ingredient.save!).to be(true)
    end
  end
  describe "without ingredient" do
    let(:recipe_ingredient) { build(:recipe_ingredient, recipe: create(:recipe)) }
    it "raises RecordInvalid exception" do
      expect{ recipe_ingredient.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  describe "without recipe" do
    let(:recipe_ingredient) { build(:recipe_ingredient, ingredient: create(:ingredient)) }
    it "raises RecordInvalid exception" do
      expect{ recipe_ingredient.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
