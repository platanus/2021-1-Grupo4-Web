require 'rails_helper'

RSpec.describe RecipeStep, type: :model do
  let(:recipe) { build(:recipe) }

  describe 'it has all the attributes' do
    let(:recipe_step) { create(:recipe_step, recipe: recipe) }

    ["number", "description"].each do |attribute|
      it "includes the #{attribute} attribute" do
        expect(recipe_step.attributes).to include(attribute)
      end
    end

    it "succeeds on save" do
      expect(recipe_step.save!).to be(true)
    end
  end

  describe 'validations' do
    let(:recipe_step) { create(:recipe_step, number: 1, description: 'A preparar!') }
    let(:recipe_step_two) { create(:recipe_step, number: 2, description: 'A comer! ') }

    it 'returns false without recipe' do
      expect(recipe_step.update(recipe: nil)).to eq(false)
    end

    it 'returns false without number' do
      expect(recipe_step.update(number: nil)).to eq(false)
    end

    it 'returns false without description' do
      expect(recipe_step.update(description: nil)).to eq(false)
    end

    it 'returns true with all correct' do
      expect(recipe_step.save).to eq(true)
    end
  end

  describe 'creating and updating step' do
    let!(:prepare) { create(:recipe_step, number: 1, description: 'A preparar!', recipe: recipe) }
    let!(:cook) { create(:recipe_step, number: 2, description: 'A cocinar!', recipe: recipe) }
    let!(:bake) { create(:recipe_step, number: 3, description: 'A hornear!', recipe: recipe) }
    let!(:decorate) { create(:recipe_step, number: 4, description: 'A decorar!', recipe: recipe) }

    it 'creates with number 6 when is new step' do
      expect(
        described_class.create(recipe: recipe, description: 'A comer jeje')
      ).to have_attributes(number: 5)
    end

    it 'returns false if number is out of range' do
      expect(decorate.update(number: 5)).to eq(false)
    end

    # rubocop:disable Layout/MultilineMethodCallIndentation
    it 'moves forward only first and second when moving third backwards' do
      expect { bake.update(number: 1) }
        .to change { prepare.reload.number }.from(1).to(2)
        .and change { cook.reload.number }.from(2).to(3)
        .and change { decorate.reload.number }.by(0)
    end

    it 'moves backward only third and fourth when moving second forward' do
      expect { cook.update(number: 4) }
        .to change { bake.reload.number }.from(3).to(2)
        .and change { decorate.reload.number }.from(4).to(3)
        .and change { prepare.reload.number }.by(0)
    end

    it 'make an exchange of positions when are consecutive on backwards' do
      expect { decorate.update(number: 3) }
        .to change { bake.reload.number }.from(3).to(4)
        .and change { decorate.reload.number }.from(4).to(3)
        .and change { cook.reload.number }.by(0)
    end

    it 'make an exchange of positions when are consecutive on forward' do
      expect { prepare.update(number: 2) }
        .to change { cook.reload.number }.from(2).to(1)
        .and change { prepare.reload.number }.from(1).to(2)
        .and change { bake.reload.number }.by(0)
    end

    it 'moves all forward when the last move to the first position' do
      expect { decorate.update(number: 1) }
        .to change { decorate.reload.number }.from(4).to(1)
        .and change { bake.reload.number }.from(3).to(4)
        .and change { cook.reload.number }.from(2).to(3)
        .and change { prepare.reload.number }.from(1).to(2)
    end

    it 'moves all backward when the fist move to the last position' do
      expect { prepare.update(number: 4) }
        .to change { decorate.reload.number }.from(4).to(3)
        .and change { bake.reload.number }.from(3).to(2)
        .and change { cook.reload.number }.from(2).to(1)
        .and change { prepare.reload.number }.from(1).to(4)
    end

    it 'does not move anything if change of step description' do
      expect { prepare.update(description: 'Era sal, no azúcar jaja') }
        .to change { decorate.reload.number }.by(0)
        .and change { bake.reload.number }.by(0)
        .and change { cook.reload.number }.by(0)
        .and change { prepare.reload.number }.by(0)
    end
    # rubocop:enable Layout/MultilineMethodCallIndentation
  end

  describe 'deleting step' do
    let!(:prepare) { create(:recipe_step, number: 1, description: 'A preparar!', recipe: recipe) }
    let!(:cook) { create(:recipe_step, number: 2, description: 'A cocinar!', recipe: recipe) }
    let!(:bake) { create(:recipe_step, number: 3, description: 'A hornear!', recipe: recipe) }
    let!(:decorate) { create(:recipe_step, number: 4, description: 'A decorar!', recipe: recipe) }

    # rubocop:disable Layout/MultilineMethodCallIndentation
    it 'reduces by 1 all when first is deleted' do
      expect { prepare.destroy! }
        .to change { cook.reload.number }.from(2).to(1)
        .and change { bake.reload.number }.from(3).to(2)
        .and change { decorate.reload.number }.from(4).to(3)
    end

    it 'moves backward only fourth' do
      expect { bake.destroy! }
        .to change { decorate.reload.number }.from(4).to(3)
        .and change { cook.reload.number }.by(0)
    end

    it 'no step number is reduced because of tail destroy' do
      expect { decorate.destroy! }
        .to change { prepare.reload.number }.by(0)
        .and change { cook.reload.number }.by(0)
        .and change { bake.reload.number }.by(0)
    end
    # rubocop:enable Layout/MultilineMethodCallIndentation
  end
end
