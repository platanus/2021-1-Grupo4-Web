require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:provider) { create(:provider) }

  it { is_expected.to have_many(:ingredients) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(provider.attributes).to include("id")
    end

    it "includes the :name attribute" do
      expect(provider.attributes).to include("name")
    end

    it "includes the :address attribute" do
      expect(provider.attributes).to include("address")
    end

    it "includes the :country attribute" do
      expect(provider.attributes).to include("country")
    end
  end
end
