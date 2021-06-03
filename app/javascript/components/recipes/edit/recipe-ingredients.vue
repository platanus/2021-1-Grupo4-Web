/* eslint-disable vue/max-len */
<template>
  <div class="flex items-start justify-between w-auto h-auto flex-none self-stretch flex-grow-0 mb-8">
    <!-- igredientes para agregar -->
    <div class="">
      <div class="flex flex-col items-start w-full h-auto flex-none flex-grow-0">
        <!-- buscador -->
        <input
          class="flex items-center py-2 px-5 w-auto h-16 bg-gray-50 border-2 border-gray-600 box-border rounded flex-none self-stretch flex-grow-0 mb-8"
          :placeholder="$t('msg.recipes.searchIngredient')"
        >
        <!-- ingredientes disponibles -->
        <div class="flex flex-col items-start w-96 h-96 flex-none flex-grow-0 bg-gray-200 overflow-scroll">
          <add-ingredient-card
            v-for="ingredient in ingredients"
            :key="ingredient.id"
            :name="ingredient.name"
            :price="ingredient.price"
            @add="addIngredient(ingredient)"
          >
            {{ ingredient.name }}
          </add-ingredient-card>
        </div>
      </div>
    </div>
    <!-- ingredientes seleccionados -->
    <div class="">
      <div class="flex flex-col items-start w-96 h-full flex-none self-stretch flex-grow bg-gray-50">
        <div class="flex items-start h-6 bg-gray-50 font-sans font-medium text-base text-black flex-none self-stretch flex-grow-0 mb-3">
          {{ $t('msg.recipes.selectedIngredients') }}
        </div>
        <div
          class="flex flex-col items-start w-96 h-96 flex-none flex-grow-0 bg-gray-200 overflow-scroll"
          v-if="recipeIngredients.length > 0"
        >
          <selected-ingredient-card
            v-for="ingredient in selectedIngredients"
            :key="ingredient.id"
            :name="ingredient.name"
            :price="ingredient.price"
            @delete="deleteIngredient(ingredient)"
          >
            {{ ingredient.name }}
          </selected-ingredient-card>
        </div>
        <div
          class="flex items-start h-6 bg-gray-50 font-sans font-light text-base text-black flex-none self-stretch flex-grow-0 mb-3"
          v-else
        >
          {{ $t('msg.recipes.noIngredients') }}
        </div>
        <div class="flex w-96 h-auto items-start justify-end py-4 px-2 bg-gray-200 border border-gray-300 box-border flex-none self-stretch flex-grow-0">
          <div class="w-auto h-6 font-bold text-base text-black flex-none flex-grow-0 mx-2">
            {{ $t('msg.recipes.recipePrice') }} ${{ recipePrice }}
          </div>
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
      selectedIngredients: [],
    };
  },
  components: {
    addIngredientCard,
    selectedIngredientCard,
  },
  props: {
    recipeIngredients: { type: Array, required: true },
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
  computed: {
    recipePrice() {
      return this.recipeIngredients.map(ingredient =>
        ingredient.attributes.ingredient.price).reduce((acc, curVal) => acc + curVal, 0);
    },
  },
  watch: {
    recipeIngredients() {
      this.selectedIngredients = this.recipeIngredients.map(element => element.attributes.ingredient);
    },
  },
  methods: {
    addIngredient(element) {
      console.log(this.selectedIngredients);
      this.selectedIngredients.push(element);
    },
    deleteIngredient(element) {
      console.log(this.selectedIngredients);
      const index = this.selectedIngredients.indexOf(element);
      if (index > -1) {
        this.selectedIngredients.splice(index, 1);
      }
    },
  },
};

</script>
