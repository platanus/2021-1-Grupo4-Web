require 'rails_helper'

RSpec.describe MenuRecipe, type: :model do
  let(:user){ create(:user) }
  let(:menu_recipe) { build(:menu_recipe, menu: create(:menu, user: user), recipe: create(:recipe, user: user)) }

  it { is_expected.to belong_to(:menu) }
  it { is_expected.to belong_to(:recipe) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(menu_recipe.attributes).to include("id")
    end

    it "includes the :recipe_quantity attribute" do
      expect(menu_recipe.attributes).to include("recipe_quantity")
    end
    it "succeeds on save" do
      expect(menu_recipe.save!).to be(true)
    end
  end
  describe "without menu" do
    let(:menu_recipe) { build(:menu_recipe, create(:recipe)) }
    it "raises RecordInvalid exception" do
      expect{ menu_recipe.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  describe "without recipe" do
    let(:menu_recipe) { build(:menu_recipe, menu: create(:menu)) }
    it "raises RecordInvalid exception" do
      expect{ menu_recipe.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
