require 'rails_helper'

RSpec.describe RecipeStep, type: :model do
  let(:recipe) { build(:recipe) }

  describe 'it has all the attributes' do
    let(:recipe_step) { create(:recipe_step, recipe: recipe) }

    ["step_order", "description"].each do |attribute|
      it "includes the #{attribute} attribute" do
        expect(recipe_step.attributes).to include(attribute)
      end
    end

    it "succeeds on save" do
      expect(recipe_step.save!).to be(true)
    end
  end

  describe 'validations' do
    let(:recipe_step) { create(:recipe_step, step_order_position: 0, description: 'A preparar!') }
    let(:recipe_step_two) { create(:recipe_step, step_order_position: 1, description: 'A comer! ') }

    it 'returns false without recipe' do
      expect(recipe_step.update(recipe: nil)).to eq(false)
    end

    it 'returns false without description' do
      expect(recipe_step.update(description: nil)).to eq(false)
    end

    it 'returns true with all correct' do
      expect(recipe_step.save).to eq(true)
    end
  end

  describe 'creating and updating step' do
    let!(:prepare) do
      create(:recipe_step, step_order_position: 0, description: 'A preparar!', recipe: recipe)
    end
    let!(:cook) do
      create(:recipe_step, step_order_position: 1, description: 'A cocinar!', recipe: recipe)
    end
    let!(:bake) do
      create(:recipe_step, step_order_position: 2, description: 'A hornear!', recipe: recipe)
    end
    let!(:decorate) do
      create(:recipe_step, step_order_position: 3, description: 'A decorar!', recipe: recipe)
    end

    it 'creates with step_order 6 when is new step' do
      expect(
        described_class.create(recipe: recipe, description: 'A comer jeje')
      ).to have_attributes(step_order_rank: 4)
    end

    it 'moves forward only first and second when moving third backwards' do
      expect { bake.update(step_order_position: 0) }
        .to change { prepare.reload.step_order_rank }
        .from(0).to(1)
        .and change { cook.reload.step_order_rank }
        .from(1).to(2)
        .and change { decorate.reload.step_order_rank }
        .by(0)
    end

    it 'moves backward only third and fourth when moving second forward' do
      expect { cook.update(step_order_position: 3) }
        .to change { bake.reload.step_order_rank }
        .from(2).to(1)
        .and change { decorate.reload.step_order_rank }
        .from(3).to(2)
        .and change { prepare.reload.step_order_rank }
        .by(0)
    end

    it 'make an exchange of positions when are consecutive on backwards' do
      expect { decorate.update(step_order_position: 2) }
        .to change { bake.reload.step_order_rank }
        .from(2).to(3)
        .and change { decorate.reload.step_order_rank }
        .from(3).to(2)
        .and change { cook.reload.step_order_rank }
        .by(0)
    end

    it 'make an exchange of positions when are consecutive on forward' do
      expect { prepare.update(step_order_position: 1) }
        .to change { cook.reload.step_order_rank }
        .from(1).to(0)
        .and change { prepare.reload.step_order_rank }
        .from(0).to(1)
        .and change { bake.reload.step_order_rank }
        .by(0)
    end

    it 'moves all forward when the last move to the first position' do
      expect { decorate.update(step_order_position: 0) }
        .to change { decorate.reload.step_order_rank }
        .from(3).to(0)
        .and change { bake.reload.step_order_rank }
        .from(2).to(3)
        .and change { cook.reload.step_order_rank }
        .from(1).to(2)
        .and change { prepare.reload.step_order_rank }
        .from(0).to(1)
    end

    it 'moves all backward when the fist move to the last position' do
      expect { prepare.update(step_order_position: 3) }
        .to change { decorate.reload.step_order_rank }
        .from(3).to(2)
        .and change { bake.reload.step_order_rank }
        .from(2).to(1)
        .and change { cook.reload.step_order_rank }
        .from(1).to(0)
        .and change { prepare.reload.step_order_rank }
        .from(0).to(3)
    end

    it 'does not move anything if change of step description' do
      expect { prepare.update(description: 'Era sal, no azúcar jaja') }
        .to change { decorate.reload.step_order_rank }
        .by(0)
        .and change { bake.reload.step_order_rank }
        .by(0)
        .and change { cook.reload.step_order_rank }
        .by(0)
        .and change { prepare.reload.step_order_rank }
        .by(0)
    end
  end

  describe 'deleting step' do
    let!(:prepare) do
      create(:recipe_step, step_order_position: 0, description: 'A preparar!', recipe: recipe)
    end
    let!(:cook) do
      create(:recipe_step, step_order_position: 1, description: 'A cocinar!', recipe: recipe)
    end
    let!(:bake) do
      create(:recipe_step, step_order_position: 2, description: 'A hornear!', recipe: recipe)
    end
    let!(:decorate) do
      create(:recipe_step, step_order_position: 3, description: 'A decorar!', recipe: recipe)
    end

    it 'reduces by 1 all when first is deleted' do
      expect { prepare.destroy! }
        .to change { cook.reload.step_order_rank }
        .from(1).to(0)
        .and change { bake.reload.step_order_rank }
        .from(2).to(1)
        .and change { decorate.reload.step_order_rank }
        .from(3).to(2)
    end

    it 'moves backward only fourth' do
      expect { bake.destroy! }
        .to change { decorate.reload.step_order_rank }
        .from(3).to(2)
        .and change { cook.reload.step_order_rank }
        .by(0)
    end

    it 'no step_order_rank is reduced because of tail destroy' do
      expect { decorate.destroy! }
        .to change { prepare.reload.step_order_rank }
        .by(0)
        .and change { cook.reload.step_order_rank }
        .by(0)
        .and change { bake.reload.step_order_rank }
        .by(0)
    end
  end
end
