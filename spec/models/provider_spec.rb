require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:subject) { create(:provider) }

  describe 'it has all the attributes' do
    it "includes the :id attribute" do
      expect(subject.attributes).to include("id")
    end

    it "includes the :name attribute" do
      expect(subject.attributes).to include("name")
    end

    it "includes the :address attribute" do
      expect(subject.attributes).to include("address")
    end

    it "includes the :country attribute" do
      expect(subject.attributes).to include("country")
    end
  end

  describe 'it has many ingredients' do
    it { is_expected.to have_many(:ingredients) }
  end
end
