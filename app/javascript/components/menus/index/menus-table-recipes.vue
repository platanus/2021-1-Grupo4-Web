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
      <div class="mr-20">
        <p class="text-lg">
          {{ $t('msg.recipes.title') }}:
        </p>
        <div
          v-for="recipe in menu.menuRecipes.data"
          :key="recipe.attributes.recipe.id"
          class="flex justify-start text-gray-700 rounded-md px-2 py-2 my-2"
        >
          <span class="bg-gray-600 h-2 w-2 m-2 rounded-full" />
          <div class="flex-grow text-sm px-2">
            {{ recipe.attributes.recipeQuantity }} {{ recipe.attributes.recipe.name }}
          </div>
        </div>
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
