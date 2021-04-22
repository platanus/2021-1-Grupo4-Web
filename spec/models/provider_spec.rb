require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:subject) { create(:provider) }
  describe 'it has all the attributes' do
    it "should include the :id attribute" do
      expect(subject.attributes).to include("id")
    end
    it "should include the :name attribute" do
      expect(subject.attributes).to include("name")
    end
    it "should include the :address attribute" do
      expect(subject.attributes).to include("address")
    end
    it "should include the :country attribute" do
      expect(subject.attributes).to include("country")
    end
  end
  describe 'it has many ingredients' do
    it { should have_many(:ingredients) }
  end
end
