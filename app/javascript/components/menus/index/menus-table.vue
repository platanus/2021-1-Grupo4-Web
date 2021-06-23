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
        />
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
          class="py-2 px-8"
        >
          <menus-table-recipes
            :menu="menu"
          />
        </td>
        <td
          class="content-center"
        >
          <menu-shopping-list
            :menu-id="menu.id"
          />
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
  </table>
</template>

<script>
import MenusTableRecipesQuantity from './menus-table-recipes-quantity';
import MenusTableRecipes from './menus-table-recipes';
import MenuShoppingList from './menu-shopping-list';

export default {
  components: {
    MenusTableRecipesQuantity,
    MenusTableRecipes,
    MenuShoppingList,
  },
  props: {
    menus: { type: Array, required: true },
  },
  methods: {
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
