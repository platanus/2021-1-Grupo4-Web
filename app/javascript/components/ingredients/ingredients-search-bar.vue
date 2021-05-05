<template>
  <div class="flex my-4 items-center justify-start">
    <form method="GET">
      <div class="relative text-yellow-700">
        <span
          v-if="searchIcon"
          class="absolute inset-y-0 left-0 flex items-center pl-2"
        >
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
          class="border-2 w-full border-yellow-700 py-2 text-sm text-yellow-700 focus:outline-none focus:bg-white focus:text-yellow-700"
          :class="searchIcon ? 'pl-10' : 'pl-2'"
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
    searchIcon: { type: Boolean, required: true },
  },
};
</script>
