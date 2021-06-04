<template>
  <div class="w-96">
    <div class="flex space-x-4">
      <input
        :placeholder="$t(`msg.ingredients.search`)"
        class="w-full mx-1 my-4 p-2 border-2 rounded border-gray-300"
      />
    </div>
    <table class="min-w-full divide-y divide-gray-200 border-2">
      <thead class="justify-between">
        <tr class="bg-gray-100  py-1">
          <th
            class="border-solid border-2 border-color-gray-300 text-center"
            v-for="(attribute, idx) in header"
            :key="idx"
          >
            <span class="text-black font-bold">{{ $t(`msg.ingredients.${attribute}`) }}</span>
          </th>
          <th />
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(ingredient, idx) in ingredients"
          :key="idx"
          class="bg-white border-2"
        >
          <td
            v-for="property in header"
            :key="property"
            class="content-center py-2 border-solid border-2"
          >
            <p class="content-center text-center ml-2 font-semibold">
              {{ ingredient[property] }}
            </p>
          </td>
          <td class="content-center py-2">
            <p class="content-center text-center mx-4 font-semibold">
              <button
                class="focus:outline-none hover:bg-gray-100"
                @click="addIngredient(ingredient)"
              >
                <div class="text-xl">
                  +
                </div>
              </button>
            </p>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  props: {
    ingredients: { type: Array, required: true },
  },
  data() {
    return {
      header: ['name', 'price', 'quantity', 'measure'],
    };
  },
  methods: {
    addIngredient(object) {
      this.$emit('add-ingredient', object);
    },
  },
};
</script>
