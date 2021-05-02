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

    it "succeeds on save" do
      expect(ingredient.save!).to be(true)
    end
  end

  describe "without user" do
    let(:ingredient) { build(:ingredient, user: nil) }

    it "raises RecordInvalid exception" do
      expect { ingredient.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
