<template>
  <div>
    <!-- Title and Back Button -->
    <div class="flex items-center">
      <a href="/recipes">
        <img
          class="h-6 w-6 text-white mx-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="h-7 font-sans font-lg text-2xl text-black font-bold flex-grow mx-2">
        {{ this.recipe.name }}
      </div>
    </div>

    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-1">
        <!--Info-->
        <recipe-info
          :portions="recipe.portions"
          :cook-minutes="recipe.cookMinutes"
          :recipe-price="recipePrice"
        />
        <!-- Buttons -->
        <div class="flex items-center">
          <button
            class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-red-600 rounded flex-grow-0 mx-2 text-red-600 focus:outline-none"
            @click="toggleDelModal"
          >
            {{ $t('msg.recipes.delete') }}
          </button>
          <a
            :href="`/recipes/${recipeId}/edit`"
            class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-gray-800 rounded flex-grow-0 mx-2 text-gray-800 focus:outline-none"
          >
            {{ $t('msg.recipes.edit') }}
          </a>
        </div>
      </div>

      <!-- Body-->
      <div class="flex items-start justify-between w-auto h-auto self-stretch flex-grow-0 my-4">
        <recipe-ingredients :recipe-ingredients="this.recipe.recipeIngredients.data" />
      </div>
      <div class="flex items-start justify-between w-auto h-auto self-stretch flex-grow-0 my-4">
        <recipe-instructions :steps="this.recipe.steps.data" />
      </div>
    </div>

    <!--DeleteModal-->
    <base-modal
      @ok="deleteRecipe"
      @cancel="toggleDelModal"
      v-if="showingDel"
      :title="$t('msg.recipes.delete')"
      :ok-button-label="$t('msg.yesDelete')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <p>{{ $t('msg.recipes.deleteMsg') }}</p>
    </base-modal>
  </div>
</template>

<script>

import { getRecipe, deleteRecipe } from '../../../api/recipes.js';
import RecipeIngredients from './recipe-ingredients';
import RecipeInstructions from './recipe-instructions';
import RecipeInfo from './recipe-info';

export default {
  components: {
    RecipeIngredients,
    RecipeInstructions,
    RecipeInfo,
  },

  props: {
    recipeId: { type: Number, required: true },
  },

  data() {
    return {
      showingDel: false,
      status: '',
      error: '',
      recipe: {
        name: '',
        portions: 0,
        cookMinutes: 0,
        recipeIngredients: { data: [] },
        steps: { data: [] },
      },
    };
  },

  async created() {
    try {
      const response = await getRecipe(this.recipeId);
      this.recipe = { id: response.data.data.id, ...response.data.data.attributes };
      this.status = status;
    } catch (error) {
      this.error = error;
    }
  },

  methods: {
    toggleDelModal() {
      this.showingDel = !this.showingDel;
    },
    ingredientFinalPrice(quantity, price) {
      return (quantity * price);
    },
    async deleteRecipe() {
      try {
        await deleteRecipe(this.recipe.id);
        window.location.href = '/recipes';
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },
    getPriceOfSelectedIngredient(recipeIngredient) {
      if (!recipeIngredient.ingredientQuantity) return 0;

      return recipeIngredient.ingredientQuantity * this.unitaryPrice(recipeIngredient);
    },

    unitaryPrice(recipeIngredient) {
      const defaultQuantity = recipeIngredient.ingredient.otherMeasures.data.map(element =>
        element.attributes).filter(element =>
        element.name === recipeIngredient.ingredientMeasure)[0].quantity;
      const price = recipeIngredient.ingredient.price / defaultQuantity;
      if (this.isInt(price)) {
        return price;
      }

      return Math.round(recipeIngredient.ingredient.price / defaultQuantity);
    },
    isInt(n) {
      return n % 1 === 0;
    },
  },

  computed: {
    recipePrice() {
      return this.recipe.recipeIngredients.data.reduce((recipePrice, recipeIngredient) =>
        recipePrice + this.getPriceOfSelectedIngredient(recipeIngredient.attributes), 0);
    },
  },
};
</script>
