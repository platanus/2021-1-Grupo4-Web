<template>
  <div class="flex items-start justify-between w-auto h-auto flex-none self-stretch flex-grow-0 mb-8">
    <!-- igredientes para agregar -->
    <div class="flex flex-col items-start w-3/6 h-auto flex-none flex-grow-0">
      <!-- buscador -->
      <input
        class="flex items-center py-2 px-5 w-auto h-16 bg-gray-50 border-2 border-gray-600 box-border rounded flex-none self-stretch flex-grow-0 mb-8"
        :placeholder="$t('msg.recipes.searchIngredient')"
      >
      <!-- ingredientes disponibles -->
      <div class="flex flex-col items-start w-full h-96 flex-none flex-grow-0 bg-gray-200 overflow-scroll">
        <add-ingredient-card
          v-for="ingredient in this.ingredients"
          :key="ingredient.id"
          :name="ingredient.name"
          :price="ingredient.price"
        >
          {{ ingredient.name }}
        </add-ingredient-card>
      </div>
    </div>
    <!-- ingredientes seleccionados -->
    <div class="flex flex-col items-start w-2/5 h-full flex-none self-stretch flex-grow bg-gray-50">
      <div class="flex items-start h-6 bg-gray-50 font-hind font-medium text-base text-black flex-none self-stretch flex-grow-0 mb-3">
        {{ $t('msg.recipes.selectedIngredients') }}
      </div>
      <div class="flex flex-col items-start w-full h-96 flex-none flex-grow-0 bg-gray-200 overflow-scroll">
        <selected-ingredient-card
          v-for="ingredient in this.ingredients"
          :key="ingredient.id"
          :name="ingredient.name"
          :price="ingredient.price"
        >
          {{ ingredient.name }}
        </selected-ingredient-card>
      </div>
      <div class="flex w-auto h-auto items-start justify-end py-4 px-2 bg-gray-200 border border-gray-300 box-border flex-none self-stretch flex-grow-0">
        <div class="w-auto h-6 font-bold text-base text-black flex-none flex-grow-0 mx-2">
          Total del menú
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getIngredients } from './../../../api/ingredients.js';
import addIngredientCard from './add-ingredient-card.vue';
import selectedIngredientCard from './selected-ingredient-card.vue';

export default {
  data() {
    return {
      ingredients: [],
      error: '',
    };
  },
  components: {
    addIngredientCard,
    selectedIngredientCard,
  },
  async created() {
    try {
      const response = await getIngredients();
      this.ingredients = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    }
  },
};
</script>
