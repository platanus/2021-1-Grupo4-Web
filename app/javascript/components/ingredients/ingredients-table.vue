<template>
  <div class="w-full">
    <table
      class="w-full divide-y divide-gray-200"
    >
      <thead class="justify-between bg-gray-600 border-2 border-gray-600">
        <tr class="text-left items-center">
          <th class="pl-6 py-3 w-72">
            <span class="text-white font-bold">{{ $t('msg.ingredients.name') }}</span>
          </th>
          <th class="px-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.provider') }}</span>
          </th>
          <th class="px-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.price') }}</span>
          </th>
          <th class="px-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.quantity') }}</span>
          </th>
          <th class="px-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.measure') }}</span>
          </th>
          <th class="px-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.unitPrice') }}</span>
          </th>
          <th class="px-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.title') }}</span>
          </th>
          <th class="py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.minimumQuantityShort') }}</span>
          </th>
          <th class="px-4 py-3" />
        </tr>
      </thead>
      <tbody class="bg-gray-200">
        <tr
          v-for="(ingredient, idx) in ingredients"
          :key="ingredient.id"
          class="bg-white border-2 border-gray-200 text-left font-normal"
        >
          <!-- ingredient name -->
          <td class="pl-6 py-3">
            <p>
              {{ ingredient.name }}
            </p>
          </td>
          <td class="px-4 py-3">
            <p>
              {{ ingredient.providerName === null ? "-" : ingredient.providerName }}
            </p>
          </td>
          <!-- price -->
          <td class="py-2 px-4">
            <p>
              {{ ingredient.price | currency }}
            </p>
          </td>
          <!-- quantity -->
          <td class="py-2 px-4">
            <p>
              {{ ingredient.quantity }}
            </p>
          </td>
          <td class="py-2 px-4">
            <p>
              {{ ingredient.measure }}
            </p>
          </td>
          <td class="py-2 px-4">
            <ingredients-table-unit-price
              :ingredient="ingredient"
            />
          </td>
          <td class="py-2 px-4">
            <div
              class="flex justify-start"
            >
              <img
                svg-inline
                src="../../../assets/images/pencil-svg.svg"
                class="w-4 h-4 cursor-pointer"
                @click="openEditInventory(idx)"
              >
              <div class="flex">
                <input
                  type="number"
                  min="0"
                  ref="inventory"
                  class="w-12 m-auto border-none outline-none text-center"
                  v-model="ingredient.inventory"
                  @blur.prevent="changeInventory(ingredient, ingredient.inventory)"
                >
                <div class="flex m-auto">
                  {{ ingredient.measure }}
                </div>
              </div>
            </div>
          </td>
          <!-- minimum quantity -->
          <td class="py-2">
            <p
              class="ml-2 font-medium"
              v-if="ingredient.minimumQuantity == ''"
            >
              0
            </p>
            <p
              class="ml-2 font-medium"
              v-if="ingredient.minimumQuantity != undefined"
            >
              {{ ingredient.minimumQuantity }}
            </p>
            <p
              class="ml-2 font-medium"
              v-if="ingredient.minimumQuantity == undefined"
            >
              0
            </p>
          </td>
          <td class="content-center">
            <dots-dropdown
              :elements="{
                edit:true,
                del:true,
                last: lastIngredient(idx)
              }"
              @edit="editIngredient(ingredient)"
              @delete="deleteIngredient(ingredient)"
            />
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import IngredientsTableUnitPrice from './ingredients-table-unit-price';

export default {
  components: {
    IngredientsTableUnitPrice,
  },
  props: {
    ingredients: { type: Array, required: true },
  },

  data() {
    return {
      originalIngredients: [...this.ingredients].map(element => JSON.parse(JSON.stringify(element))),
    };
  },

  methods: {
    editIngredient(element) {
      this.$emit('edit', element);
    },
    deleteIngredient(element) {
      this.$emit('del', element);
    },
    openEditInventory(idx) {
      this.$nextTick(() => {
        this.$refs.inventory[idx].focus();
      });
    },
    changeInventory(ingredient, inventory) {
      if (inventory && parseFloat(inventory) >= 0) {
        ingredient.inventory = inventory;
        this.$emit('updateInventory', ingredient);
      } else {
        const originalIngredient = this.originalIngredients.filter(original => original.id === ingredient.id)[0];
        ingredient.inventory = originalIngredient.inventory;
      }
    },
    lastIngredient(idx) {
      if (idx === this.ingredients.length - 1) {
        return true;
      }

      return false;
    },
  },
};
</script>
