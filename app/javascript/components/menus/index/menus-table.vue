<template>
  <table class="min-w-full divide-y divide-gray-200">
    <thead class="justify-between">
      <tr class="bg-yellow-500 border-4 border-yellow-500 py-1 text-left">
        <th
          class="pl-2"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.name') }}</span>
        </th>
        <th
          class="pl-2"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.totalPrice') }}</span>
        </th>
        <th
          class="pl-2"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.recipesQuantity') }}</span>
        </th>
        <th
          class="pl-2"
        >
          <span class="text-white font-bold">{{ $t('msg.menus.recipes') }}</span>
        </th>
        <th />
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="menu in menus"
        :key="menu.id"
        class="bg-white border-4 border-gray-200"
      >
        <!-- name -->
        <td
          key="name"
          class="content-center py-2 pl-2"
        >
          <p
            class="content-center font-semibold text-left"
          >
            {{ menu.name }}
          </p>
        </td>
        <!-- totalPrice -->
        <td
          key="totalPrice"
          class="content-center py-2 pl-2"
        >
          <p
            class="content-center font-semibold text-left"
          >
            {{ 20.000 }}
          </p>
        </td>
        <!-- recipesQuantity -->
        <td
          key="recipesQuantity"
          class="content-center py-2 pl-2"
        >
          <menus-table-recipes-quantity
            :menu="menu"
          />
        </td>
        <!-- recipes -->
        <td
          key="recipes"
          class="content-center py-2 pl-2"
        >
          <div
            class="flex flex-col"
          >
            <div
              v-for="recipe in menu.recipes"
              :key="recipe"
            >
              {{ recipe }}
            </div>
          </div>
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
            @edit="editIngredient(parsedElement)"
            @del="deleteIngredient"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import MenusTableRecipesQuantity from './menus-table-recipes-quantity';

export default {
  components: {
    MenusTableRecipesQuantity,
  },

  props: {
    menus: { type: Array, required: true },
  },
  methods: {
    editIngredient(element) {
      this.$emit('edit', element);
    },
    deleteIngredient() {
      this.$emit('del');
    },
  },
};

</script>
