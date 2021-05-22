<template>
  <table class="divide-y divide-gray-200">
    <thead class="justify-between bg-gray-600 border-4 border-gray-600">
      <tr class="text-left">
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.results') }}</span>
        </th>
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="recipe in hardcodedRecipesResult"
        :key="recipe.id"
        class="bg-white border-2 border-gray-200 text-left"
      >
        <td key="recipe">
          <search-results-item
            :recipe="recipe"
            :recipes-of-menu="hardcodedMenuRecipes"
            @pushRecipe="pushRecipe"
            @removeRecipe="removeRecipe"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import SearchResultsItem from './search-results-item';

export default {
  components: {
    SearchResultsItem,
  },

  props: {
    recipesResult: { type: Array, required: true },
    menuToEdit: { type: Object, required: true },
    hardcodedMenuRecipes: { type: Array, required: true },
  },

  // this goes when connected to backend
  data() {
    return {
      hardcodedRecipesResult: this.recipesResult,
    };
  },

  // this goes when connected to backend
  created() {
    const hardcodedRecipe1 = { name: 'Mix de ensaladas', id: 1, portions: 5, cookMinutes: 60 };
    const hardcodedRecipe2 = { name: 'Cheescake de Frambuesa', id: 2, portions: 10, cookMinutes: 120 };
    this.hardcodedRecipesResult = [...this.hardcodedRecipesResult, hardcodedRecipe1, hardcodedRecipe2];
  },

  methods: {
    pushRecipe(recipe) {
      this.$emit('pushRecipe', recipe);
    },

    removeRecipe(recipe) {
      this.$emit('removeRecipe', recipe);
    },
  },
};

</script>
