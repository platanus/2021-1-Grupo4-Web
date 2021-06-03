<template>
  <div class="flex justify-center items-start p-3 w-auto h-auto bg-gray-20 border border-gray-300 flex-none self-stretch flex-grow-0">
    <!-- 3 puntitos -->
    <div class="flex items-center w-3 h-5 flex-none self-stretch flex-grow-0 mx-4">
      <img
        class="h-5 w-3 text-white"
        svg-inline
        src="../../../../assets/images/dots-vertical-svg.svg"
      >
    </div>
    <!-- numero paso -->
    <div class="flex flex-col justify-center w-6 h-6 bg-yellow-500 shadow-sm rounded-full flex-none flex-grow-0 items-center mr-4 ">
      <div class="font-sans font-normal text-lg text-white my-auto">
        {{ index + 1 }}
      </div>
    </div>
    <!-- descripcion paso -->
    <div class="flex w-auto h-auto font-sans font-normal text-base text-black bg-gray-20 flex-none flex-grow mr-4">
      {{ step }}
    </div>
  </div>
</template>

<script>

export default {
  props: {
    step: { type: String, required: true },
    index: { type: Number, required: true },
  },
};
</script>
