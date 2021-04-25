require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:recipes) }
  it { is_expected.to have_many(:menus) }
  it { is_expected.to have_many(:ingredients) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(user.attributes).to include("id")
    end

    it "includes the :name attribute" do
      expect(user.attributes).to include("email")
    end

    it "includes the :encrypted_password attribute" do
      expect(user.attributes).to include("encrypted_password")
    end

    it "includes the :reset_password_token attribute" do
      expect(user.attributes).to include("reset_password_token")
    end

    it "includes the :authentication_token attribute" do
      expect(user.attributes).to include("authentication_token")
    end
  end
end
