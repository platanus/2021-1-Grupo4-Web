require 'rails_helper'

RSpec.describe Menu, type: :model do
  let(:menu) { build(:menu) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:recipes).through(:menu_recipes) }
  it { is_expected.to have_many(:menu_recipes) }

  describe 'it has all the attributes' do
    it "includes the :name attribute" do
      expect(menu.attributes).to include("name")
    end
    it "succeeds on save" do
      expect(menu.save!).to be(true)
    end
  end
  describe "without user" do
    let(:menu) { build(:menu, user: nil) }
    it "raises RecordInvalid exception" do
      expect{ menu.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
