require 'rails_helper'

RSpec.describe MenuRecipe, type: :model do
  describe MenuRecipe do
    subject(:menu_recipe) { build(:menu_recipe) }
    it { is_expected.to belong_to(:menu) }
  end
  describe MenuRecipe do
    subject(:menu_recipe) { build(:menu_recipe) }
    it { is_expected.to belong_to(:recipe) }
  end
  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(subject.attributes).to include("id")
    end
    it "includes the :recipe_quantity attribute" do
      expect(subject.attributes).to include("recipe_quantity")
    end
  end
end
