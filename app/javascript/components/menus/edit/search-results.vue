<template>
  <table class="divide-y divide-gray-200">
    <thead class="justify-between bg-gray-600 border-4 border-gray-600">
      <tr class="text-left">
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.results') }}</span>
        </th>
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="recipeResult in recipesResult"
        :key="recipeResult.id"
        class="bg-white border-2 border-gray-200 text-left"
      >
        <td key="recipe">
          <search-results-item
            :recipe="recipeResult"
            :recipes-of-menu="menuToEdit.menuRecipes.data"
            @push="pushRecipe"
            @remove="removeRecipe"
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
  },

  methods: {
    pushRecipe(recipeResult) {
      const defaultQuantity = 1;
      const recipeToPush = { attributes: { recipe: recipeResult, recipeQuantity: defaultQuantity } };
      this.$emit('pushRecipe', recipeToPush);
    },

    removeRecipe(recipeResult) {
      this.$emit('removeRecipe', recipeResult);
    },
  },
};
</script>
