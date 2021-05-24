<template>
  <div class="flex-col ml-10">
    <div class="flex items-center pl-3 bg-gray-600 border-4 border-gray-600 text-left text-white font-bold  h-10">
      {{ $t('msg.menus.selectedRecipes') }} ({{ numberOfResults }})
    </div>
    <div
      v-for="recipe in selectedRecipes"
      :key="recipe.id"
      class="bg-white border-2 border-gray-200 text-left"
    >
      <selected-recipes-item
        :recipe="recipe"
      />
    </div>
    <div class="pr-4 pb-4 bg-gray-200 border-4 text-right text-black h-14">
      <p class="block text-xs">
        {{ $t('msg.menus.addedSubtotal') }}: $10.000
      </p>
      <p class="block text-xs">
        {{ $t('msg.menus.previousSubtotal') }}: $10.000
      </p>
      <p class="block text-xs font-bold">
        {{ $t('msg.menus.totalMenuPrice') }}: $20.000
      </p>
    </div>
  </div>
</template>

<script>
import SelectedRecipesItem from './selected-recipes-item';

export default {
  components: {
    SelectedRecipesItem,
  },

  props: {
    selectedRecipes: { type: Array, required: true },
  },

  computed: {
    numberOfResults() {
      return this.selectedRecipes.length;
    },
  },
};

</script>
