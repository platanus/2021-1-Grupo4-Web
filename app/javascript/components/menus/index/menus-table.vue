<template>
  <table class="w-full divide-y divide-gray-200">
    <thead class="justify-between bg-gray-600 border-4 border-gray-600">
      <tr class="text-left">
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.name') }}</span>
        </th>
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.totalCost') }}</span>
        </th>
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.portions') }}</span>
        </th>
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.recipesQuantity') }}</span>
        </th>
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.recipes') }}</span>
        </th>
        <th
          class="px-8 py-3"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.actions') }}</span>
        </th>
        <th
          class="px-8 py-3"
        />
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="menu in menus"
        :key="menu.id"
        class="bg-white border-4 border-gray-200 text-left"
      >
        <!-- name -->
        <td
          key="name"
          class="py-2 px-8"
        >
          <p
            class="ml-2 font-medium"
          >
            {{ menu.name }}
          </p>
        </td>
        <!-- totalPrice -->
        <td
          key="totalPrice"
          class="py-2 px-8"
        >
          <p
            class="ml-2 font-medium"
          >
            {{ totalMenuPrice(menu.menuRecipes.data) | currency }}
          </p>
        </td>
        <td
          key="portions"
          class="py-2 px-8"
        >
          <p
            class="ml-2 font-medium"
          >
            {{ menu.portions }}
          </p>
        </td>
        <!-- recipesQuantity -->
        <td
          key="recipesQuantity"
          class="py-2 px-8"
        >
          <menus-table-recipes-quantity
            :menu="menu"
          />
        </td>
        <!-- recipes -->
        <td
          key="recipes"
          class="py-2 px-4"
        >
          <menus-table-recipes
            :menu="menu"
          />
        </td>
        <td
          class="content-center py-2 px-8 items-center"
        >
          <div class="flex flex-col">
            <div class="flex w-full justify-between">
              <menu-shopping-list
                class="flex w-5/12 m-auto"
                :menu-id="menu.id"
                @reduceInventory="toggleReduce"
              />
              <div class="flex w-7/12">
                Lista de Compras
              </div>
            </div>
            <div class="flex w-full justify-between">
              <div class="flex w-5/12 m-auto">
                <img
                  svg-inline
                  src="../../../../assets/images/reduce-inventory-svg.svg"
                  class="w-6 h-6 cursor-pointer"
                  @click="toggleReduce(menu.id)"
                >
              </div>
              <div class="flex w-7/12">
                Restar Inventario
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
              del:true
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
  </table>
</template>

<script>
import MenusTableRecipesQuantity from './menus-table-recipes-quantity';
import MenusTableRecipes from './menus-table-recipes';
import MenuShoppingList from './menu-shopping-list';
import { reduceInventoryApi } from '../../../api/menus';

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
        const ingredientUnitaryPrice = this.unitaryPrice(element.attributes);
        returnArray.push(ingredientQuantity * ingredientUnitaryPrice);
      });

      return returnArray;
    },
    unitaryPrice(recipeIngredient) {
      const defaultQuantity = recipeIngredient.ingredient.otherMeasures.data.map(element =>
        element.attributes).filter(element =>
        element.name === recipeIngredient.ingredientMeasure)[0].quantity;
      const price = recipeIngredient.ingredient.price / defaultQuantity;
      if (this.isInt(price)) {
        return price;
      }

      return Math.round(recipeIngredient.ingredient.price / defaultQuantity);
    },
    isInt(n) {
      return n % 1 === 0;
    },
  },
};
</script>
