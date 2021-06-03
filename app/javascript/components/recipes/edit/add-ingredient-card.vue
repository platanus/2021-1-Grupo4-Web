<template>
  <div class="flex items-start justify-between w-full h-20 border border-gray-500 bg-gray-50 flex-none flex-grow-0">
    <!-- data -->
    <div class="flex flex-col items-start w-auto h-14 flex-none flex-grow-0 mx-3 my-auto">
      <div class="w-auto h-7 font-hind font-bold text-lg text-black flex-none flex-grow-0 mb-0.5">
        {{ name }}
      </div>
      <div class="flex items-center w-auto h-5 flex-none flex-grow-0">
        <div class="w-auto h-5 font-hind font-light text-sm text-gray-600 flex-none flex-grow-0 mr-0.5">
          {{ $t('msg.recipes.price') }} {{ $t('msg.recipes.unitary') }}
        </div>
        <div class="w-auto h-5 font-hind font-normal text-sm text-black flex-none flex-grow-0">
          $ {{ price }} CLP
        </div>
      </div>
    </div>
    <!-- button -->
    <button
      class="flex items-center py-1.5 px-4 w-auto h-9 bg-yellow-500 shadow-sm rounded-md flex-none flex-grow-0 my-auto mx-3"
      @click="addIngredient()"
    >
      <div class="w-auto h-6 font-hind font-normal text-base text-white flex-none flex-grow-0">
        {{ $t('msg.ingredients.searchAdd') }}
      </div>
    </button>
  </div>
</template>

<script>

export default {
  props: {
    name: { type: String, required: true },
    price: { type: Number, required: true },
  },
  methods: {
    addIngredient() {
      this.$emit('add');
    },
  },
};
</script>
