<template>
  <div>
    <!--Title-->
    <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-1">
      <div class="flex items-center">
        <a href="/recipes">
          <img
            class="h-6 w-6 text-white mx-2"
            svg-inline
            src="../../../../assets/images/arrow-left-svg.svg"
          >
        </a>
        <div class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
          {{ this.recipe.name }}
        </div>
      </div>
      <div class="flex items-center">
        <button
          class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-purple-600 rounded flex-grow-0 mx-2 text-purple-600"
          @click="toggleDelModal"
        >
          {{ $t('msg.recipes.delete') }}
        </button>
        <button class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-blue-700 rounded flex-grow-0 mx-2 text-blue-700">
          {{ $t('msg.recipes.edit') }}
        </button>
      </div>
    </div>
    <!--Info-->
    <recipe-info
      :portions="recipe.portions"
      :cook-minutes="recipe.cookMinutes"
      :recipe-price="recipePrice"
    />
    <!--Body-->
    <div class="flex items-start justify-between w-auto h-auto self-stretch flex-grow-0 my-4">
      <recipe-ingredients :recipe-ingredients="this.recipe.recipeIngredients.data" />
      <recipe-instructions :steps="this.recipe.steps.data" />
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

export default {
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
      this.successResponse(response);
    } catch (error) {
      this.errorResponse(error);
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
        const response = await deleteRecipe(this.recipe.id);
        window.location.href = '/recipes';
        this.successResponse(response);
      } catch (error) {
        this.errorResponse(error);
      }
    },
    async successResponse(status) {
      this.status = status;
      this.error = '';
    },
    async errorResponse(error) {
      this.status = error.response.status;
      this.error = error;
    },
  },

  computed: {
    recipePrice() {
      return this.recipe.recipeIngredients.data.map(element =>
        this.ingredientFinalPrice(element.attributes.ingredient.quantity,
          element.attributes.ingredient.price)).reduce((acc, curVal) => acc + curVal, 0);
    },
  },
};
</script>
