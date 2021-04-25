require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe Menu do
    subject(:menu) { build(:menu) }
    it { is_expected.to belong_to(:user) }
  end
  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(subject.attributes).to include("id")
    end
    it "includes the :name attribute" do
      expect(subject.attributes).to include("name")
    end
  end
  describe 'it has many recipes' do
    it { is_expected.to have_many(:menu_recipes) }
  end
  describe Menu do
    it { should have_many(:recipes).through(:menu_recipes) }
  end
end
