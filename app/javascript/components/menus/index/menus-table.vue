<template>
  <table class="min-w-full divide-y divide-gray-200">
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
          <span class="text-white font-bold">{{ $t('msg.menus.totalPrice') }}</span>
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
            {{ 20000 | currency }}
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
        <!-- dots -->
        <td
          class="content-center"
        >
          <dots-dropdown
            :elements="{
              edit:true,
              del:true
            }"
            @edit="editIngredient(menu)"
            @del="deleteIngredient(menu)"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import MenusTableRecipesQuantity from './menus-table-recipes-quantity';
import MenusTableRecipes from './menus-table-recipes';

export default {
  components: {
    MenusTableRecipesQuantity,
    MenusTableRecipes,
  },
  props: {
    menus: { type: Array, required: true },
  },
  methods: {
    editIngredient(element) {
      this.$emit('edit', element);
    },
    deleteIngredient(element) {
      this.$emit('del', element);
    },
  },
};
</script>
