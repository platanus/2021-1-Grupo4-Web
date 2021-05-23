<template>
  <div class="flex flex-col items-start pt-4 min-w-min h-auto flex-grow-0 ml-2">
    <div class="w-28 h-6 font-sans font-normal text-lg text-black font-bold flex-grow-0 mt-2.5 mb-6">
      {{ $t('msg.ingredients.title') }}
    </div>
    <div class="flex items-center">
      <p
        v-if="recipeIngredients.length === 0"
      >
        {{ $t('msg.noElements') }} {{ $t('msg.ingredients.title') }}
      </p>
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="justify-between bg-gray-600 border-4 border-gray-600">
          <tr class="text-left">
            <th class="px-8 py-3">
              <span class="text-white font-bold">{{ $t('msg.ingredients.name') }}</span>
            </th>
            <th class="px-8 py-3">
              <span class="text-white font-bold">{{ $t('msg.ingredients.quantity') }}</span>
            </th>
            <th class="px-8 py-3">
              <span class="text-white font-bold">{{ $t('msg.ingredients.measure') }}</span>
            </th>
          </tr>
        </thead>
        <tbody class="bg-gray-200">
          <tr
            v-for="ingredient in recipeIngredients"
            :key="ingredient.attributes.ingredient.id"
            class="bg-white border-4 border-gray-200 text-left"
          >
            <!-- ingredient name -->
            <td class="py-2 px-8">
              <p class="ml-2 font-medium">
                {{ ingredient.attributes.ingredient.name }}
              </p>
            </td>
            <!-- quantity in recipe -->
            <td class="py-2 px-8">
              <p class="ml-2 font-medium">
                {{ ingredient.attributes.ingredientQuantity }}
              </p>
            </td>
            <!-- ingredient unit -->
            <td class="py-2 px-8">
              <p class="ml-2 font-medium">
                {{ ingredient.attributes.ingredient.measure }}
              </p>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipeIngredients: { type: Array, required: true },
  },
};
</script>
