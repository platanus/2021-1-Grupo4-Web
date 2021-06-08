/* eslint-disable vue/max-len */
<template>
  <div class="flex justify-between mb-8">
    <!-- igredientes para agregar -->
    <div class="w-1/2 p-4">
      <div class="flex flex-col">
        <!-- buscador -->
        <input
          class="flex items-center py-2 px-5 w-auto h-16 bg-gray-50 border-2 border-gray-600 box-border rounded self-stretch mb-8"
          :placeholder="$t('msg.recipes.searchIngredient')"
          v-model="query"
        >
        <!-- ingredientes disponibles -->
        <div class="flex flex-col bg-gray-200 overflow-scroll">
          <add-ingredient-card
            v-for="ingredient in filteredIngredients"
            :key="ingredient.id"
            :name="ingredient.name"
            :price="ingredient.price / ingredient.quantity"
            @add="addIngredient(ingredient)"
          >
            {{ ingredient.name }}
          </add-ingredient-card>
        </div>
      </div>
    </div>
    <!-- ingredientes seleccionados -->
    <div class="w-1/2 p-4">
      <div class="flex flex-col self-stretch flex-grow bg-gray-50">
        <div class="flex h-6 bg-gray-50 font-sans font-medium text-base text-black self-stretch mb-3">
          {{ $t('msg.recipes.selectedIngredients') }}
        </div>
        <div
          class="flex flex-col bg-gray-200 overflow-scroll"
          v-if="recipeIngredients.length > 0"
        >
          <div
            v-for="(recipeIngredient, idx) in recipeIngredients"
            :key="recipeIngredient.id"
          >
            <selected-ingredient-card
              :recipe-ingredient-idx="idx"
              :recipe-ingredient-attrs="recipeIngredient.attributes"
              @delete-ingredient="deleteIngredient"
              @increase-quantity="increaseQuantity"
              @decrease-quantity="decreaseQuantity"
            >
              {{ recipeIngredient.attributes.ingredient.name }}
            </selected-ingredient-card>
          </div>
        </div>
        <div
          class="flex h-6 bg-gray-50 font-sans font-light text-base text-black self-stretch mb-3"
          v-else
        >
          {{ $t('msg.recipes.noIngredients') }}
        </div>
        <div class="flex justify-end py-4 px-2 bg-gray-200 border border-gray-300 box-border self-stretch">
          <div class="w-auto h-6 font-bold text-base text-black mx-2">
            {{ $t('msg.recipes.recipePrice') }} $ {{ recipePrice }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getIngredients } from '../../../api/ingredients.js';
import addIngredientCard from './add-ingredient-card.vue';
import selectedIngredientCard from '../edit/selected-ingredient-card.vue';

export default {
  data() {
    return {
      ingredients: [],
      error: '',
      query: '',
    };
  },
  components: {
    addIngredientCard,
    selectedIngredientCard,
  },
  props: {
    recipeIngredients: { type: Array, required: false, default() {
      return [];
    } },
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
      return this.recipeIngredients.reduce((recipePrice, recipeIngredient) =>
        recipePrice + this.getPriceOfSelectedIngredient(recipeIngredient.attributes), 0);
    },
    filteredIngredients() {
      if (this.query) {
        return this.ingredients.filter(item => this.query
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.ingredients;
    },
  },
  methods: {
    addIngredient(ingredient) {
      this.$emit('add-ingredient', ingredient);
    },
    deleteIngredient(recipeIngredientIdx) {
      this.$emit('delete-ingredient', recipeIngredientIdx);
    },
    increaseQuantity(recipeIngredientIdx) {
      this.$emit('increase-quantity', recipeIngredientIdx);
    },
    decreaseQuantity(recipeIngredientIdx) {
      this.$emit('decrease-quantity', recipeIngredientIdx);
    },
    getPriceOfSelectedIngredient(recipeIngredient) {
      if (!recipeIngredient.ingredientQuantity) return 0;

      return recipeIngredient.ingredientQuantity *
      recipeIngredient.ingredient.price / recipeIngredient.ingredient.quantity;
    },
  },
};

</script>
