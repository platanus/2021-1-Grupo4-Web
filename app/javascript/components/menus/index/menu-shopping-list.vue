<template>
  <div class="w-full m-auto">
    <button
      class="focus:outline-none"
      @click="toogleList"
    >
      <img
        svg-inline
        src="../../../../assets/images/shopping-bag-svg.svg"
        class="w-6 h-6 text-yellow-700"
      >
    </button>
    <base-modal
      @cancel="toogleList"
      v-if="showingList"
      :title="$t('msg.menus.shoppingList')"
      :cancel-button-label="$t('msg.menus.closeShoppingList')"
      :ok-button-present="false"
    >
      <div
        v-if="!loading"
      >
        <div class="pb-6">
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

        <div class="flex">
          <button
            class="focus:outline-none bg-gray-300 hover:bg-gray-400 p-4 mx-2 my-2 h-10 font-bold py-2 px-6 rounded shadow-md"
            @click="downloadShoppingList"
          >
            <div class="flex">
              <div class="text-md">
                {{ $t('msg.download') }}
              </div>
              <img
                svg-inline
                src="../../../../assets/images/download-svg.svg"
                class="w-6 h-6"
              >
            </div>
          </button>
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

import { getShoppingList, downloadShoppingList } from '../../../api/menus';

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
    async toogleList() {
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
    async downloadShoppingList() {
      const response = await downloadShoppingList(this.menuId);
      const blob = new Blob(
        [response.data], {
          type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        },
      );
      const link = document.createElement('a');
      link.download = 'shopping-list.xlsx';
      link.href = URL.createObjectURL(blob);
      link.click();
      URL.revokeObjectURL(link.href);
      this.toogleList();
    },
  },
};

</script>
