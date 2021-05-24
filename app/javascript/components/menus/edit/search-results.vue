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
        v-for="recipe in recipesResult"
        :key="recipe.id"
        class="bg-white border-2 border-gray-200 text-left"
      >
        <td key="recipe">
          <search-results-item
            :recipe="recipe"
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
    pushRecipe(recipe) {
      const menuRecipesIds = this.menuToEdit.menuRecipes.data.map((element) => element.id);
      // If recipe is already part of menu
      let recipeToPush = {};
      if (menuRecipesIds.includes(recipe.id)) {
        const menuRecipe = this.menuToEdit.menuRecipes.data.filter(item => item.id === recipe.id)[0];
        recipeToPush = { ...menuRecipe.attributes.recipe, recipeQuantity: menuRecipe.attributes.recipeQuantity };
      } else {
        const defaultQuantity = 1;
        recipeToPush = { ...recipe, recipeQuantity: defaultQuantity };
      }
      this.$emit('pushRecipe', recipeToPush);
    },

    removeRecipe(recipe) {
      this.$emit('removeRecipe', recipe);
    },
  },
};

</script>
