<template>
  <div class="w-full">
    <table
      class="divide-y divide-gray-200 w-full"
    >
      <thead class="justify-between bg-gray-600 border-4 border-gray-600">
        <tr class="text-left items-center w-full">
          <th class="px-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.name') }}</span>
          </th>
          <th class="px-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.actualQuantity') }}</span>
          </th>
          <th class="px-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.increaseIn') }}</span>
          </th>
          <th class="px-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.decreaseIn') }}</span>
          </th>
          <th class="px-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.resulting') }}</span>
          </th>
        </tr>
      </thead>
      <tbody class="bg-gray-200">
        <tr
          v-for="(ingredient, idx) in ingredients"
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
              {{ actualInventories[idx] === null ? "-" : actualInventories[idx] }}
            </p>
          </td>
          <!-- increase in -->
          <td class="py-2 px-8">
            <p class="ml-2 font-medium">
              <input
                type="number"
                :min="0"
                ref="increase-inventory"
                class="w-10 border-2 border-solid border-gray-400 box-border"
                v-model="increaseInventoryIn[idx]"
                @change="changeInventory(ingredient, idx)"
              > {{ ingredient.measure }}
            </p>
          </td>
          <!-- deacrease in -->
          <td class="py-2 px-8">
            <p class="ml-2 font-medium">
              <input
                type="number"
                min="0"
                :max="maxDecrease(idx)"
                ref="decrease-inventory"
                class="w-10 border-2 border-solid border-gray-400 box-border"
                v-model="decreaseInventoryIn[idx]"
                @change="changeInventory(ingredient, idx)"
              > {{ ingredient.measure }}
            </p>
          </td>
          <!-- resulting -->
          <td class="py-2 px-8">
            <div
              class="flex justify-between"
            >
              <p class="ml-2 font-medium">
                {{ ingredient.inventory }}
              </p>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>

export default {
  data() {
    return {
      increaseInventoryIn: [],
      decreaseInventoryIn: [],
      actualInventories: [],
    };
  },
  props: {
    ingredients: { type: Array, required: true },
  },
  methods: {
    changeInventory(ingredient, idx) {
      ingredient.inventory = this.actualInventories[idx] + parseFloat(this.increaseInventoryIn[idx]) -
      parseFloat(this.decreaseInventoryIn[idx]);
      this.$emit('updateIngredientInventory', ingredient);
    },
    maxDecrease(idx) {
      return this.actualInventories[idx] + this.increaseInventoryIn[idx];
    },
  },
  created() {
    this.actualInventories = this.ingredients.map(element => element.inventory);
    this.increaseInventoryIn = new Array(this.ingredients.length).fill(0);
    this.decreaseInventoryIn = new Array(this.ingredients.length).fill(0);
  },
};
</script>
