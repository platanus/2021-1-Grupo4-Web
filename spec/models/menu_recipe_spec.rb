require 'rails_helper'

RSpec.describe MenuRecipe, type: :model do
  let(:menu_recipe) { build(:menu_recipe) }

  it { is_expected.to belong_to(:menu) }
  it { is_expected.to belong_to(:recipe) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(menu_recipe.attributes).to include("id")
    end

    it "includes the :recipe_quantity attribute" do
      expect(menu_recipe.attributes).to include("recipe_quantity")
    end
  end
end
