<template>
  <div class="flex justify-between items-center flex-grow-0 mb-6">
    <input
      class="flex py-2 px-5 w-96 h-16 bg-gray-50 border-2 border-gray-400 rounded self-stretch flex-grow-0"
      :placeholder="placeholder"
      autocomplete="off"
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
