<template>
  <div class="flex flex-col">
    <!-- nombre -->
    <div class="flex items-center">
      <a :href="`/recipes/${recipeId}`">
        <img
          class="h-6 w-6 text-white mr-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="h-7 font-sans font-lg text-2xl text-black font-bold flex-grow">
        {{ this.recipe.name }}
      </div>
    </div>
    <!-- cuadro blanco edición -->
    <div class="flex flex-col py-8 px-6 w-auto h-auto bg-gray-50 flex-grow-0 my-4">
      <!-- datos básicos -->
      <div
        class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8"
      >
        1. {{ $t('msg.recipes.basic') }}
      </div>
      <recipe-basic-info
        :name="this.recipe.name"
        :portions="this.recipe.portions"
        :cook-minutes="this.recipe.cookMinutes"
      />
      <!-- ingredients -->
      <div class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8">
        2. {{ $t('msg.recipes.ingredients') }}
      </div>
      <recipe-ingredients :recipe-ingredients="this.recipe.recipeIngredients.data" />
    </div>
  </div>
</template>

<script>
import { getRecipe } from '../../../api/recipes.js';
import recipeBasicInfo from './recipe-basic-info.vue';
import recipeIngredients from './recipe-ingredients.vue';

export default {
  props: {
    recipeId: { type: Number, required: true },
  },
  components: {
    recipeBasicInfo,
    recipeIngredients,
  },
  data() {
    return {
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
};
</script>
