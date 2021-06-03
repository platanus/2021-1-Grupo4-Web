<template>
  <div class="flex items-start justify-between w-full h-20 border border-gray-500 bg-gray-50 flex-none flex-grow-0">
    <!-- data -->
    <div class="flex flex-col items-start w-auto h-16 flex-none flex-grow-0 mx-3 my-auto">
      <div class="w-auto h-6 font-hind font-bold text-lg text-black flex-none flex-grow-0 mb-0.5">
        {{ name }}
      </div>
      <div class="flex items-center w-auto h-5 flex-none flex-grow-0 mb-0.5">
        <div class="w-auto h-5 font-hind font-light text-sm text-gray-600 flex-none flex-grow-0 mr-0.5">
          {{ $t('msg.recipes.price') }} {{ $t('msg.recipes.unitary') }}
        </div>
        <div class="w-auto h-5 font-hind font-normal text-sm text-black flex-none flex-grow-0">
          $ {{ price }} CLP
        </div>
      </div>
      <div class="flex items-center w-auto h-4 flex-none flex-grow-0">
        <div class="w-auto h-4 font-hind font-normal text-xs text-gray-600 flex-none flex-grow-0 mr-2">
          {{ $t('msg.recipes.portions') }}
        </div>
        <button class="w-3 h-3 rounded-sm bg-gray-200 shadow-sm flex-none flex-grow-0 mr-0.5">
          <img
            class="h-3 w-3 text-white m-auto"
            svg-inline
            src="../../../../assets/images/plus-svg.svg"
          >
        </button>
        <input class="w-5 h-3 bg-gray-20 border border-gray-200 flex-none flex-grow-0 mr-0.5">
        <button class="w-3 h-3 rounded-sm bg-gray-200 shadow-sm flex-none flex-grow-0">
          <img
            class="h-3 w-3 text-white m-auto"
            svg-inline
            src="../../../../assets/images/minus-svg.svg"
          >
        </button>
      </div>
    </div>
    <!-- button -->
    <div class="flex flex-col justify-center items-end w-auto h-20 flex-none self-stretch mr-2">
      <button class="w-3 h-3 bg-red-500 shadow-sm rounded-md flex-none flex-grow-0 mb-1.5"
      @click="deleteIngredient()">
        <img
          class="h-3 w-3 text-white m-auto"
          svg-inline
          src="../../../../assets/images/cross-svg.svg"
        >
      </button>
      <div class="w-auto h-6 font-sans font-medium text-base text-right text-black flex-none flex-grow-0">
        8.240
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    name: { type: String, required: true },
    price: { type: Number, required: true },
  },
  methods: {
    deleteIngredient() {
      console.log("delete");
      this.$emit('delete');
    },
  },
};
</script>
