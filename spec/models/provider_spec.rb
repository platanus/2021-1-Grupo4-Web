require 'rails_helper'

RSpec.describe Provider, type: :model do
  let!(:user) { create(:user) }
  let(:provider) { create(:provider, user: user) }

  it { is_expected.to have_many(:ingredients) }

  describe 'it has all the attributes' do
    ["name", "address", "country"].each do |attribute|
      it "includes the #{attribute} attribute" do
        expect(provider.attributes).to include(attribute)
      end
    end

    it "succeeds on save" do
      expect(provider.save!).to be(true)
    end
  end
end
