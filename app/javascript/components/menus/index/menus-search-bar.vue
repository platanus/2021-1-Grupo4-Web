<template>
  <div class="flex justify-start items-center flex-grow-0 pr-10">
    <input
      class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-400 rounded self-stretch flex-grow-0"
      :placeholder="placeholder"
      autocomplete="off"
    >
    <img
      svg-inline
      src="../../../../assets/images/magnifyng-glass-svg.svg"
      class="w-6 h-6 absolute left-5 top-5"
    >
  </div>
</template>

<script>
export default {
  props: {
    placeholder: { type: String, required: true },
  },
};

</script>
