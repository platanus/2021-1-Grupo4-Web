<template>
  <div class="w-full m-auto">
    <button
      class="focus:outline-none"
      @click="showList"
    >
      <img
        svg-inline
        src="../../../../assets/images/shopping-bag-svg.svg"
        class="w-6 h-6 text-yellow-700"
      >
    </button>
    <base-modal
      @cancel="showList"
      v-if="showingList"
      :title="$t('msg.menus.shoppingList')"
      :cancel-button-label="$t('msg.menus.closeShoppingList')"
      :ok-button-present="false"
    >
      <div
        v-if="!loading"
      >
        <div
          v-for="(element, idx) in menuIngredients"
          :key="idx"
        >
          <div class="flex flex-col pb-3">
            <div class="text-md font-bold">
              {{ element.provider }}
            </div>
            <div
              class="flex text-sm"
              v-for="(ingredient, ingredient_idx) in element.ingredients"
              :key="ingredient_idx"
            >
              {{ formatIngredientInfo(ingredient) }}
            </div>
          </div>
        </div>
      </div>
      <span
        v-else
        class="flex justify-center m-auto w-8 h-8"
      >
        <base-spinner />
      </span>
    </base-modal>
  </div>
</template>

<script>

import { getShoppingList } from '../../../api/menus';

export default {
  props: {
    menuId: { type: String, required: true },
  },
  data() {
    return {
      showingList: false,
      menuIngredients: [],
      loading: true,
    };
  },
  methods: {
    async showList() {
      this.showingList = !this.showingList;

      if (this.menuIngredients.length > 0) return;

      this.loading = true;
      const menuIngredientsResponse = await getShoppingList(this.menuId);
      this.menuIngredients = menuIngredientsResponse.data;
      this.loading = false;
    },
    formatIngredientInfo(ingredient) {
      return `${ingredient.name}, ${ingredient.quantity} ${ingredient.measure}, $ ${ingredient.totalPrice}`;
    },
  },
};

</script>
