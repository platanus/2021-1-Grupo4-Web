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
      :title="menu.name"
      :ok-button-present="false"
      :cancel-button-label="$t('msg.cancel')"
    >
      <p>{{ $t('msg.menus.menuRecipes') }}</p>
      <base-one-column-table
        :header="$t('msg.recipes.title')"
        :rows="allMenuRecipes"
      />
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
    allMenuRecipes() {
      return this.menu.menuRecipes.data.map((recipe) =>
        `${recipe.attributes.recipeQuantity} ${recipe.attributes.recipe.name}`);
    },
  },

  methods: {
    toggleSeeMore() {
      this.showingSeeMore = !this.showingSeeMore;
    },
  },

};
</script>
