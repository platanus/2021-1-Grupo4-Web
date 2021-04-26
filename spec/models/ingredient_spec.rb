require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { build(:ingredient) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:provider).optional }
  it { is_expected.to have_many(:recipe_ingredients) }
  it { is_expected.to have_many(:recipes).through(:recipe_ingredients) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(ingredient.attributes).to include("id")
    end

    it "includes the :name attribute" do
      expect(ingredient.attributes).to include("name")
    end

    it "includes the :sku attribute" do
      expect(ingredient.attributes).to include("sku")
    end

    it "includes the :price attribute" do
      expect(ingredient.attributes).to include("price")
    end

    it "includes the :currency attribute" do
      expect(ingredient.attributes).to include("currency")
    end

    it "includes the :quantity attribute" do
      expect(ingredient.attributes).to include("quantity")
    end

    it "includes the :measure attribute" do
      expect(ingredient.attributes).to include("measure")
    end

    it "succeeds on save" do
      expect(ingredient.save!).to be(true)
    end
  end
  describe "without user" do
    let(:ingredient) { build(:ingredient, user: nil) }
    it "raises RecordInvalid exception" do
      expect{ ingredient.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
