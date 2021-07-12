<template>
  <div class="w-full">
    <table class="w-full divide-y divide-gray-200">
      <thead class="justify-between bg-gray-600 border-2 border-gray-600">
        <tr class="text-left">
          <th
            class="px-6 py-3 w-60"
          >
            <span class="text-white font-bold">{{ $t('msg.menus.name') }}</span>
          </th>
          <th
            class="px-6 py-3"
          >
            <span class="text-white font-bold">{{ $t('msg.menus.totalCost') }}</span>
          </th>
          <th
            class="px-6 py-3"
          >
            <span class="text-white font-bold">{{ $t('msg.menus.portions') }}</span>
          </th>
          <th
            class="px-6 py-3"
          >
            <span class="text-white font-bold">{{ $t('msg.menus.recipesQuantity') }}</span>
          </th>
          <th
            class="px-6 py-3"
          >
            <span class="text-white font-bold">{{ $t('msg.menus.recipes') }}</span>
          </th>
          <th
            class="px-6 py-3"
          >
            <span class="text-white font-bold">{{ $t('msg.menus.actions') }}</span>
          </th>
          <th
            class="px-4 py-3"
          />
        </tr>
      </thead>
      <tbody class="bg-gray-200">
        <tr
          v-for="(menu, idx) in menus"
          :key="menu.id"
          class="bg-white border-2 border-gray-200 text-left"
        >
          <!-- name -->
          <td
            key="name"
            class="py-2 px-6"
          >
            <p>
              {{ menu.name }}
            </p>
          </td>
          <!-- totalPrice -->
          <td
            key="totalPrice"
            class="py-2 px-6"
          >
            <p>
              {{ totalMenuPrice(menu.menuRecipes.data) | currency }}
            </p>
          </td>
          <td
            key="portions"
            class="py-2 px-6"
          >
            <p>
              {{ menu.portions }}
            </p>
          </td>
          <!-- recipesQuantity -->
          <td
            key="recipesQuantity"
            class="py-2 px-6"
          >
            <menus-table-recipes-quantity
              :menu="menu"
            />
          </td>
          <!-- recipes -->
          <td
            key="recipes"
            class="py-2 px-6"
          >
            <menus-table-recipes
              :menu="menu"
            />
          </td>
          <td
            class="content-center py-4 px-6 items-center"
          >
            <div class="flex flex-col">
              <menu-shopping-list
                :menu-id="menu.id"
                @reduceInventory="toggleReduce"
              />
              <div
                class="flex w-full cursor-pointer"
                @click="toggleReduce(menu.id)"
              >
                <div class="flex mr-2">
                  <img
                    svg-inline
                    src="../../../../assets/images/reduce-inventory-svg.svg"
                    class="w-6 h-6"
                  >
                </div>
                <div class="flex">
                  {{ $t('msg.menus.reduceInventory') }}
                </div>
              </div>
            </div>
          </td>
          <td
            class="content-center"
          >
            <dots-dropdown
              :elements="{
                edit:true,
                del:true,
                last: lastMenu(idx)
              }"
              @edit="editMenu(menu)"
              @delete="deleteMenu(menu)"
            />
          </td>
        </tr>
      </tbody>
      <base-modal
        @ok="reduceInventory"
        @cancel="toggleReduce"
        v-if="showingReduceMsg"
        :title="$t('msg.menus.reduceInventory')"
        :ok-button-label="$t('msg.menus.yesReduce')"
        :cancel-button-label="$t('msg.cancel')"
      >
        <p>{{ $t('msg.menus.reduceMsg') }}</p>
      </base-modal>
      <base-modal
        @cancel="toggleMessageReduction"
        v-if="showReductionOfInventory"
        :title="$t('msg.menus.reduceInventory')"
        :cancel-button-label="$t('msg.close')"
        :ok-button-present="false"
      >
        <div
          v-for="(messages, idx) in ListMessages"
          :key="idx"
        >
          <div
            v-for="(message, msg_idx) in messages"
            :key="msg_idx"
          >
            <p>{{ message }}</p>
          </div>
        </div>
      </base-modal>
    </table>
  </div>
</template>

<script>
import MenusTableRecipesQuantity from './menus-table-recipes-quantity';
import MenusTableRecipes from './menus-table-recipes';
import MenuShoppingList from './menu-shopping-list';
import { reduceInventoryApi, getShoppingList } from '../../../api/menus';
import { unitaryPrice } from '../../../utils/recipeUtils.js';

export default {
  components: {
    MenusTableRecipesQuantity,
    MenusTableRecipes,
    MenuShoppingList,
  },
  data() {
    return {
      error: '',
      showingReduceMsg: false,
      showReductionOfInventory: false,
    };
  },
  props: {
    menus: { type: Array, required: true },
  },
  methods: {
    async reduceInventory() {
      try {
        await reduceInventoryApi(this.idMenuToReduce);
        this.showingReduceMsg = !this.showingReduceMsg;
      } catch (error) {
        this.error = error;
      }
      const menuIngredientsResponse = await getShoppingList(this.idMenuToReduce);
      this.menuIngredients = menuIngredientsResponse.data;
      this.toggleMessageReduction();
    },
    toggleMessageReduction() {
      this.ListMessages = this.getMessageofReduction(this.menuIngredients);
      this.showReductionOfInventory = ! this.showReductionOfInventory;
    },
    getMessageofReduction(menuIngredients) {
      const listOfMessages = menuIngredients.map((obj) =>
        obj.ingredients.map((element) =>
          `Has reducido ${element.quantity} ${element.measure} de ${element.name} y quedaste en ${element.inventory}
           ${element.measure}`,
        ));

      return listOfMessages;
    },
    toggleReduce(menuId) {
      this.showingReduceMsg = !this.showingReduceMsg;
      this.idMenuToReduce = menuId;
    },
    editMenu(element) {
      window.location = `/menus/${element.id}/edit`;
    },
    deleteMenu(element) {
      this.$emit('del', element);
    },
    totalMenuPrice(data) {
      let finalPrice = 0;
      data.forEach(element => {
        const recipeQuantity = element.attributes.recipeQuantity;
        const ingredients = this.calculateIngredients(element.attributes.recipe.recipeIngredients.data);
        ingredients.forEach(ingredientPriced => {
          finalPrice += recipeQuantity * ingredientPriced;
        });
      });

      return finalPrice;
    },
    calculateIngredients(data) {
      const returnArray = [];
      data.forEach(element => {
        const ingredientQuantity = element.attributes.ingredientQuantity;
        const ingredientUnitaryPrice = unitaryPrice(element.attributes);
        returnArray.push(Math.round(ingredientQuantity * ingredientUnitaryPrice));
      });

      return returnArray;
    },
    lastMenu(idx) {
      return (idx === this.menus.length - 1);
    },
  },
};
</script>
