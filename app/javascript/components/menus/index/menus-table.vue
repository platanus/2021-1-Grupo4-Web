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
            class="content-center py-2 px-6 items-center"
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
        @cancel="toggleCloseReduceModal"
        v-if="showingReduceMsg"
        :title="$t('msg.menus.reduceInventory')"
        :ok-button-label="$t('msg.menus.yesReduce')"
        :cancel-button-label="$t('msg.cancel')"
      >
        <div
          v-if="!loading"
        >
          <p class="text-md font-bold">
            Ingredientes a reducir inventario
          </p>
          <div
            v-for="(messages, idx) in listOfMessagesToConfirmWithInventory"
            :key="idx"
          >
            <div
              v-for="(message, msg_idx) in messages"
              :key="msg_idx"
            >
              <p>
                {{ message }}
              </p>
            </div>
          </div>
          <br>
          <div class="flex">
            <p class="text-md font-bold">
              Ingredientes con falta de inventario
            </p>
            <div
              v-if="anyElementWithoutInventory"
            >
              <p
                class="px-1"
              >
                (Si reduces, quedaran en 0)
              </p>
            </div>
          </div>
          <div
            v-for="(messages, index) in listOfMessagesToConfirmWithoutInventory"
            :key="`toReduce${index}`"
          >
            <div
              v-for="(message, msg_idx) in messages"
              :key="`toReduce${msg_idx}`"
            >
              <p>
                {{ message }}
              </p>
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
            <p v-html="message">
              {{ message }}
            </p>
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
      loading: true,
      numberToGetDecimals: 100,
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
          `Has reducido ${Math.round(element.quantity * this.numberToGetDecimals) / this.numberToGetDecimals}
          ${element.measure} de <strong>${element.name} </strong> y quedaste en <strong> 
          ${Math.round(element.inventory * this.numberToGetDecimals) / this.numberToGetDecimals} 
          ${element.measure} </strong>`,
        ));

      return listOfMessages;
    },

    getMessageConfirmationElementsWithInventory(menuIngredients) {
      const listOfMessagesWithInventory = menuIngredients.map((obj) =>
        obj.ingredients.map((element) => {
          let nuevoInventario = (element.inventory - element.quantity).toFixed(this.numberDecimals);
          nuevoInventario = Math.round(nuevoInventario * this.numberToGetDecimals) / this.numberToGetDecimals;
          if (nuevoInventario >= 0) {
            return ` ${element.name}: de ${Math.round(element.inventory * this.numberToGetDecimals) /
            this.numberToGetDecimals} a ${nuevoInventario} ${element.measure}`;
          }

          return '';
        },
        ));

      return listOfMessagesWithInventory;
    },
    getMessageConfirmationElementsWithoutInventory(menuIngredients) {
      this.anyElementWithoutInventory = false;
      const listOfMessagesWithoutInventory = menuIngredients.map((obj) =>
        obj.ingredients.map((element) => {
          const nuevoInventario = element.inventory - element.quantity;
          if (nuevoInventario < 0) {
            this.anyElementWithoutInventory = true;

            return `${element.name}: ${Math.round(element.quantity * this.numberToGetDecimals) /
            this.numberToGetDecimals} ${element.measure} (Tienes ${Math.round(element.inventory *
            this.numberToGetDecimals) / this.numberToGetDecimals} ${element.measure})`;
          }

          return '';
        },
        ));

      return listOfMessagesWithoutInventory;
    },
    toggleCloseReduceModal() {
      this.showingReduceMsg = !this.showingReduceMsg;
    },

    async toggleReduce(menuId) {
      this.idMenuToReduce = menuId;
      const menuIngredientsResponse = await getShoppingList(menuId);
      const menuIngredients = menuIngredientsResponse.data;
      this.listOfMessagesToConfirmWithInventory =
      this.getMessageConfirmationElementsWithInventory(menuIngredients);
      this.listOfMessagesToConfirmWithoutInventory =
      this.getMessageConfirmationElementsWithoutInventory(menuIngredients);

      this.showingReduceMsg = !this.showingReduceMsg;

      this.loading = false;
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
      const finalRowsCount = 2;

      return idx >= this.menus.length - finalRowsCount;
    },
  },
};
</script>
