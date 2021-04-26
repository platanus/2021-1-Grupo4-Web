require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:menu_recipes) }
  it { is_expected.to have_many(:menus).through(:menu_recipes) }
  it { is_expected.to have_many(:recipe_ingredients) }
  it { is_expected.to have_many(:ingredients).through(:recipe_ingredients) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(recipe.attributes).to include("id")
    end

    it "includes the :name attribute" do
      expect(recipe.attributes).to include("name")
    end

    it "includes the :portions attribute" do
      expect(recipe.attributes).to include("portions")
    end

    it "includes the :instructions attribute" do
      expect(recipe.attributes).to include("instructions")
    end

    it "includes the :cook_minutes attribute" do
      expect(recipe.attributes).to include("cook_minutes")
    end
    it "succeeds on save" do
      expect(recipe.save!).to be(true)
    end
  end
  describe "without user" do
    let(:recipe) { build(:recipe, user: nil) }
    it "raises RecordInvalid exception" do
      expect{ recipe.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
