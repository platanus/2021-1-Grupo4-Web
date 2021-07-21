<template>
  <div class="w-full flex flex-col overflow-auto lg:overflow-visible">
    <table
      class="w-full divide-y divide-gray-200"
    >
      <thead class="justify-between bg-gray-600 border-2 border-gray-600">
        <tr class="text-left items-center">
          <th class="pl-2 w-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.name') }}</span>
          </th>
          <th class="pl-1 w-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.provider') }}</span>
          </th>
          <th class="pl-1 w-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.price') }}</span>
          </th>
          <th class="pl-1 w-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.quantity') }}</span>
          </th>
          <th class="pl-1 w-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.measure') }}</span>
          </th>
          <th class="pl-1 pr-4 w-4 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.unitPrice') }}</span>
          </th>
          <th class="pl-1 w-14 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.inventory.title') }}</span>
          </th>
          <th class="pl-1 w-14 py-3">
            <span class="text-white font-bold">{{ $t('msg.ingredients.minimumQuantityShort') }}</span>
          </th>
          <th class="pl-1 w-6 py-3" />
        </tr>
      </thead>
      <tbody class="bg-gray-200">
        <tr
          v-for="(ingredient, idx) in pageIngredients"
          :key="ingredient.id"
          class="bg-white border-2 border-gray-200 text-left font-normal"
        >
          <!-- ingredient name -->
          <td class="pl-2 w-6 py-3">
            <p>
              {{ ingredient.name }}
            </p>
          </td>
          <td class="pl-1 w-4 py-3">
            <p>
              {{ ingredient.providerName === null ? "-" : ingredient.providerName }}
            </p>
          </td>
          <!-- price -->
          <td class="pl-1 w-4 py-3">
            <p>
              {{ ingredient.price | currency }}
            </p>
          </td>
          <!-- quantity -->
          <td class="pl-1 w-4 py-3">
            <p>
              {{ ingredient.quantity }}
            </p>
          </td>
          <td class="pl-1 w-4 py-3">
            <p>
              {{ ingredient.measure }}
            </p>
          </td>
          <td class="pl-1 w-4 py-3">
            <ingredients-table-unit-price
              :ingredient="ingredient"
            />
          </td>
          <td class="pl-1 w-14 py-3">
            <div
              class="flex justify-start"
            >
              <img
                svg-inline
                src="../../../assets/images/pencil-svg.svg"
                class="w-3 h-3 my-auto cursor-pointer"
                @click="openEditInventory(idx)"
              >
              <div class="flex">
                <input
                  type="number"
                  min="0"
                  ref="inventory"
                  class="w-10 m-auto border-none outline-none text-center"
                  v-model="ingredient.inventory"
                  @blur.prevent="changeInventory(ingredient, ingredient.inventory)"
                >
                <div class="m-auto hidden lg:flex">
                  {{ ingredient.measure }}
                </div>
              </div>
            </div>
          </td>
          <!-- minimum quantity -->
          <td class="pl-1 w-14 py-3">
            <div
              class="flex justify-start"
            >
              <img
                svg-inline
                src="../../../assets/images/pencil-svg.svg"
                class="w-3 h-3 my-auto cursor-pointer"
                @click="openEditMinimumQuantity(idx)"
              >
              <div class="flex">
                <input
                  type="number"
                  min="0"
                  ref="minimumQuantity"
                  class="w-10 m-auto border-none outline-none text-center"
                  v-model="ingredient.minimumQuantity"
                  @blur.prevent="changeMinimumQuantity(ingredient, ingredient.minimumQuantity)"
                >
                <div class="m-auto hidden lg:flex">
                  {{ ingredient.measure }}
                </div>
              </div>
            </div>
          </td>
          <td class="pl-1 w-6 py-3">
            <dots-dropdown
              class="w-6"
              :elements="{
                edit: true,
                del: true,
                last: lastIngredient(idx)
              }"
              @edit="editIngredient(ingredient)"
              @delete="deleteIngredient(ingredient)"
            />
          </td>
        </tr>
      </tbody>
    </table>
    <base-pagination
      :current-page="currentPage"
      :final-page="finalPage"
      @next="nextPage"
      @prev="prevPage"
      @change-page="changePage"
    />
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
    pageSize: { type: Number, required: true },
    filter: { type: String, required: true },
  },

  data() {
    return {
      originalIngredients: [...this.ingredients].map(element => JSON.parse(JSON.stringify(element))),
      currentPage: 1,
    };
  },
  computed: {
    pageIngredients() {
      return this.ingredients.slice(
        (this.currentPage - 1) * this.pageSize, Math.min(
          this.ingredients.length, this.currentPage * this.pageSize));
    },
    finalPage() {
      return Math.ceil(this.ingredients.length / this.pageSize);
    },
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
    openEditMinimumQuantity(idx) {
      this.$nextTick(() => {
        this.$refs.minimumQuantity[idx].focus();
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
    changeMinimumQuantity(ingredient, minimumQuantity) {
      if (minimumQuantity && parseFloat(minimumQuantity) >= 0) {
        ingredient.minimumQuantity = minimumQuantity;
        this.$emit('updateMinimumQuantity', ingredient);
      } else {
        const originalIngredient = this.originalIngredients.filter(original => original.id === ingredient.id)[0];
        ingredient.minimumQuantity = originalIngredient.minimumQuantity;
      }
    },
    lastIngredient(idx) {
      const finalRowsCount = 2;

      return idx >= this.ingredients.length - finalRowsCount;
    },
    nextPage() {
      this.currentPage += 1;
    },
    prevPage() {
      this.currentPage -= 1;
    },
    changePage(index) {
      this.currentPage = index;
    },
  },
  watch: {
    ingredients() {
      if (this.currentPage > this.finalPage) {
        this.currentPage = this.finalPage;
      }
    },
    filter() {
      this.currentPage = 1;
    },
  },
};
</script>
