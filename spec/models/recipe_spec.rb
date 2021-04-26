require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:menu_recipes) }
  it { is_expected.to have_many(:menus).through(:menu_recipes) }
  it { is_expected.to have_many(:recipe_ingredients) }
  it { is_expected.to have_many(:ingredients).through(:recipe_ingredients) }

  describe 'it has all the attributes' do
    ["name", "portions", "instructions", "cook_minutes"].each do |attribute|
      it "includes the #{attribute} attribute" do
        expect(recipe.attributes).to include(attribute)
      end
    end
  end
end
