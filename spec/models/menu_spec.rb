require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:menu) { build(:menu) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:recipes).through(:menu_recipes) }
  it { is_expected.to have_many(:menu_recipes) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(menu.attributes).to include("id")
    end

    it "includes the :name attribute" do
      expect(menu.attributes).to include("name")
    end
  end
end
