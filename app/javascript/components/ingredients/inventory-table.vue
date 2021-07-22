<template>
  <div class="w-full">
    <table
      class="divide-y divide-gray-200 w-full"
    >
      <thead class="justify-between bg-gray-600 border-2 border-gray-600">
        <tr class="text-left items-center w-full">
          <th class="pl-2 w-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.name') }}</span>
          </th>
          <th class="w-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.actualQuantity') }}</span>
          </th>
          <th class="w-12 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.increaseIn') }}</span>
          </th>
          <th class="w-12 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.decreaseIn') }}</span>
          </th>
          <th class="w-8 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.resulting') }}</span>
          </th>
        </tr>
      </thead>
      <tbody class="bg-gray-200">
        <tr
          v-for="ingredient in filteredIngredients"
          :key="ingredient.id"
          class="bg-white border-2 border-gray-200 text-left"
        >
          <!-- ingredient name -->
          <td class="py-2 w-8">
            <p class="ml-2">
              {{ ingredient.name }}
            </p>
          </td>
          <td class="py-2 w-8">
            <p class="ml-2">
              {{ ingredient.inventory === null ? "-" : ingredient.inventory }}
            </p>
          </td>
          <!-- increase in -->
          <td class="py-2 w-10">
            <p>
              <input
                type="number"
                :min="0"
                ref="increase-inventory"
                class="w-14 border-2 border-solid rounded-sm border-gray-200 box-border text-center"
                v-model="ingredient.increaseInventoryIn"
                @input="changeInventory(ingredient)"
              > {{ ingredient.measure }}
            </p>
          </td>
          <!-- deacrease in -->
          <td class="py-2 w-10">
            <p>
              <input
                type="number"
                :min="0"
                ref="decrease-inventory"
                class="w-14 border-2 border-solid rounded-sm border-gray-200 box-border text-center"
                v-model="ingredient.decreaseInventoryIn"
                @input="changeInventory(ingredient)"
              > {{ ingredient.measure }}
            </p>
          </td>
          <!-- resulting -->
          <td class="py-2 w-8">
            <div
              class="flex justify-between"
            >
              <p class="ml-2">
                {{ ingredient.finalInventory }}
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
      ingredientsWithInventories: [],
    };
  },
  props: {
    ingredients: { type: Array, required: true },
    searchQuery: { type: String, required: true },
  },
  methods: {
    changeInventory(ingredient) {
      ingredient.increaseInventoryIn = this.newIncrease(ingredient);
      ingredient.decreaseInventoryIn = this.newDecrease(ingredient);
      ingredient.finalInventory = Math.round(
        (ingredient.inventory +
        parseFloat(ingredient.increaseInventoryIn) -
        // eslint-disable-next-line no-magic-numbers
        parseFloat(ingredient.decreaseInventoryIn)) * 100) / 100;
      this.$emit('updateIngredientInventory', ingredient);
    },
    maxDecrease(ingredient) {
      return ingredient.inventory + ingredient.increaseInventoryIn;
    },
    newIncrease(ingredient) {
      return Math.max(0, ingredient.increaseInventoryIn);
    },
    newDecrease(ingredient) {
      return Math.min(
        Math.max(
          0,
          ingredient.decreaseInventoryIn,
        ),
        this.maxDecrease(ingredient),
      );
    },
  },

  computed: {
    filteredIngredients() {
      if (this.searchQuery) {
        return this.ingredientsWithInventories.filter(item => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.ingredientsWithInventories;
    },
  },
  created() {
    this.ingredients.forEach((ingredient) => {
      this.ingredientsWithInventories.push({
        name: ingredient.name,
        id: ingredient.id,
        inventory: ingredient.inventory,
        increaseInventoryIn: 0,
        decreaseInventoryIn: 0,
        finalInventory: ingredient.inventory,
      });
    });
  },
};
</script>
