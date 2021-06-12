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
            {{ ingredient.providerName }}
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
  },
};
</script>
