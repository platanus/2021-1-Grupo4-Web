<template>
  <div class="flex relative justify-between items-center flex-grow-0 mb-6">
    <input
      class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-400 rounded self-stretch flex-grow-0"
      :placeholder="placeholder"
      autocomplete="off"
    >
    <img
      svg-inline
      src="../../../assets/images/magnifyng-glass-svg.svg"
      class="w-6 h-6 absolute left-5 top-5"
    >
    <button class="flex py-2 px-10 bg-green-600 rounded-md flex-grow-0 font-hind font-normal text-lg text-white">
      Agregar menú
    </button>
  </div>
</template>

<script>
export default {
  props: {
    placeholder: { type: String, required: true },
  },
};

</script>
