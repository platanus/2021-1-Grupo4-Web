require 'rails_helper'

describe IngredientMeasureObserver do
  before do
    PowerTypes::Observable.observable_disabled = false
  end

  after do
    PowerTypes::Observable.observable_disabled = true
  end

  describe 'capitalize name of measure before save' do
    let!(:ingredient) { create(:ingredient) }
    let!(:ingredient_measure) { create(:ingredient_measure, name: 'Kg', ingredient: ingredient) }

    before { ingredient_measure.update!(name: 'gramo') }

    it 'capializes the name' do
      expect(ingredient_measure.name).to eq('Gramo')
    end
  end

  describe 'destroy or update of measure does not break recipe logic' do
    let!(:recipe) { create(:recipe) }
    let!(:ingredient) { create(:ingredient) }
    let!(:first_ingredient_measure) do
      create(:ingredient_measure, ingredient: ingredient, name: 'Kilo', quantity: 3, primary: true)
    end
    let!(:second_ingredient_measure) do
      create(:ingredient_measure, ingredient: ingredient, name: 'Gramo', quantity: 3000)
    end
    let!(:recipe_ingredient) do
      create(:recipe_ingredient, ingredient: ingredient, recipe: recipe,
                                 ingredient_measure: 'Gramo', ingredient_quantity: 1500)
    end

    before do
      ingredient.reload
      recipe.reload
    end

    it 'changes ingredient measure name that is on recipe, so changes the name also' do
      second_ingredient_measure.update!(name: 'Gramito')

      expect(recipe_ingredient.reload.ingredient_measure).to eq('Gramito')
      expect(recipe_ingredient.reload.ingredient_quantity).to eq(1500)
    end

    it 'deletes ingredient measure that is on recipe, but it changes to the existing one' do
      second_ingredient_measure.destroy!

      expect(recipe_ingredient.reload.ingredient_measure).to eq('Kilo')
      expect(recipe_ingredient.reload.ingredient_quantity).to eq(1.5)
    end
  end
end
