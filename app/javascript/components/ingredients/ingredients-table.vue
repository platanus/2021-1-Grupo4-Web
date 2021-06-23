<template>
  <table
    class="divide-y divide-gray-200"
  >
    <thead class="justify-between bg-gray-600 border-4 border-gray-600">
      <tr class="text-left items-center w-full">
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.name') }}</span>
        </th>
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.provider') }}</span>
        </th>
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.price') }}($)</span>
        </th>
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.quantity') }}</span>
        </th>
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.measure') }}</span>
        </th>
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.unitPrice') }}($)</span>
        </th>
        <th class="px-8 py-3">
          <span class="text-white font-bold">{{ $t('msg.ingredients.inventory') }}</span>
        </th>
        <th class="px-8 py-3" />
      </tr>
    </thead>
    <tbody class="bg-gray-200">
      <tr
        v-for="ingredient in ingredients"
        :key="ingredient.id"
        class="bg-white border-4 border-gray-200 text-left"
      >
        <!-- ingredient name -->
        <td class="py-2 px-8">
          <p class="ml-2 font-medium">
            {{ ingredient.name }}
          </p>
        </td>
        <td class="py-2 px-8">
          <p class="ml-2 font-medium">
            {{ ingredient.providerName === null ? "-" : ingredient.providerName }}
          </p>
        </td>
        <!-- price -->
        <td class="py-2 px-8">
          <p class="ml-2 font-medium">
            {{ ingredient.price | currency }}
          </p>
        </td>
        <!-- quantity -->
        <td class="py-2 px-8">
          <p class="ml-2 font-medium">
            {{ ingredient.quantity }}
          </p>
        </td>
        <td class="py-2 px-8">
          <p class="ml-2 font-medium">
            {{ ingredient.measure }}
          </p>
        </td>
        <td class="py-2 px-8">
          <ingredients-table-unit-price
            :ingredient="ingredient"
          />
        </td>
        <td class="py-2 px-8">
          <div
            class="flex justify-between"
            v-if="!editInventory"
          >
            <p class="ml-2 font-medium">
              {{ ingredient.inventory }} {{ ingredient.measure }}
            </p>
            <img
              svg-inline
              src="../../../assets/images/pencil-svg.svg"
              class="w-4 h-4"
              @click="toggleEditInventory"
            >
          </div>
          <div
            class="flex justify-between flex items-start items-center"
            v-else
          >
            <!-- <img
              svg-inline
              src="../../../assets/images/less-svg.svg"
              class="w-5 h-5"
              @click="subtractInventory(ingredient)"
            > -->

            <input
              type="number"
              ref="inventory"
              class="w-10 border-2 border-solid border-gray-400 box-border"
              v-model="ingredient.inventory"
              @blur.prevent="changeInventory(ingredient, ingredient.inventory)"
            >
            {{ ingredient.measure }}

            <!-- <img
              svg-inline
              src="../../../assets/images/add-svg.svg"
              class="w-5 h-5 flex items-start items-center"
              @click="addInventory(ingredient)"
            > -->
          </div>
        </td>
        <td class="content-center">
          <dots-dropdown
            :elements="{
              edit:true,
              del:true
            }"
            @edit="editIngredient(ingredient)"
            @delete="deleteIngredient(ingredient)"
          />
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import IngredientsTableUnitPrice from './ingredients-table-unit-price';

export default {
  components: {
    IngredientsTableUnitPrice,
  },
  data() {
    return {
      editInventory: false,
    };
  },

  props: {
    ingredients: { type: Array, required: true },
  },
  methods: {
    editIngredient(element) {
      this.$emit('edit', element);
    },
    deleteIngredient(element) {
      this.$emit('del', element);
    },
    toggleEditInventory() {
      this.editInventory = !this.editInventory;
    },
    // addInventory(ingredient) {
    //   // eslint-disable-next-line radix
    //   ingredient.inventory = parseInt(ingredient.inventory);
    //   ingredient.inventory += 1;
    // },
    // subtractInventory(ingredient) {
    //   if (ingredient.inventory >= 1) {
    //     ingredient.inventory -= 1;
    //   }
    // },
    changeInventory(ingredient, inventory) {
      ingredient.inventory = inventory;
      this.editInventory = !this.editInventory;
      this.$emit('updateInventory', ingredient);
    },
  },
};
</script>
