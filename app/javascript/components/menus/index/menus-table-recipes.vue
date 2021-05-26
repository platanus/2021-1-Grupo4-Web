<template>
  <div class="flex flex-col">
    <div
      v-for="recipe in firstRecipes"
      :key="recipe.attributes.recipe.id"
    >
      {{ recipe.attributes.recipeQuantity }} {{ recipe.attributes.recipe.name }}
    </div>
    <p
      v-if="seeMore"
      class="text-gray-600 cursor-pointer"
      @click="toggleSeeMore"
    >
      {{ $t('msg.seeMore') }}
    </p>

    <base-modal
      @cancel="toggleSeeMore"
      v-if="showingSeeMore"
      :title="$t('msg.recipes.title')"
      :ok-button-present="false"
      :cancel-button-label="$t('msg.cancel')"
    >
      <div
        v-for="recipe in menu.menuRecipes.data"
        :key="recipe.attributes.recipe.id"
      >
        {{ recipe.attributes.recipeQuantity }} {{ recipe.attributes.recipe.name }}
      </div>
    </base-modal>
  </div>
</template>

<script>
export default {
  props: {
    menu: { type: Object, required: true },
  },

  data() {
    return {
      showingSeeMore: false,
    };
  },

  computed: {
    firstRecipes() {
      const numberOfRecipes = 3;

      return this.menu.menuRecipes.data.slice(0, numberOfRecipes);
    },
    seeMore() {
      return this.menu.menuRecipes.data.length > this.firstRecipes.length;
    },
  },

  methods: {
    toggleSeeMore() {
      this.showingSeeMore = !this.showingSeeMore;
    },
  },

};
</script>
