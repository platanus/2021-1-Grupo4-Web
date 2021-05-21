<template>
  <div class="flex my-4 items-center justify-start">
    <form method="GET">
      <div class="relative text-yellow-700">
        <span class="absolute inset-y-0 left-0 flex items-center pl-2">
          <button
            type="submit"
            class="p-1 focus:outline-none focus:shadow-outline"
          >
            <img
              svg-inline
              src="../../../assets/images/magnifyng-glass-svg.svg"
              class="w-6 h-6 text-yellow-700"
            >
          </button>
        </span>
        <input
          type="search"
          name="q"
          class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0"
          :placeholder="placeholder"
          autocomplete="off"
        >
      </div>
    </form>
  </div>
</template>

<script>
export default {
  props: {
    placeholder: { type: String, required: true },
  },
};
</script>
