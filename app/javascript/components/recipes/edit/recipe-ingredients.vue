<template>
  <div class="flex items-start w-auto h-auto flex-none self-stretch flex-grow-0 mb-8">
    <!-- igredientes para agregar -->
    <div class="flex flex-col items-start w-3/5 h-auto flex-none flex-grow-0">
      <!-- buscador -->
      <input
        class="flex items-center py-2 px-5 w-auto h-16 bg-gray-50 border-2 border-gray-600 box-border rounded flex-none self-stretch flex-grow-0 mb-8"
        :placeholder="$t('msg.recipes.searchIngredient')"
      >
      <!-- ingredientes disponibles -->
      <div class="flex flex-col items-start w-auto h-96 flex-none flex-grow-0 bg-gray-200 overflow-scroll">
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
  </div>
</template>

<script>
import { getIngredients } from './../../../api/ingredients.js';
import addIngredientCard from './add-ingredient-card.vue';

export default {
  data() {
    return {
      ingredients: [],
      error: '',
    };
  },
  components: {
    addIngredientCard,
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
