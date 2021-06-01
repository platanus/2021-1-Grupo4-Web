<template>
  <div class="flex flex-col">
    <div class="flex items-start justify-between h-16 flex-none self-stretch flex-grow-0 mb-8">
      <input
        class="w-2/5 h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
        :placeholder="name"
      >
      <input
        class="w-1/4 h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
        :placeholder="portions"
      >
      <input
        class="w-1/4 h-16 bg-gray-50 border border-gray-600 box-border rounded-md flex-none flex-grow-0 px-5"
        :placeholder="cookMinutes"
      >
    </div>
  </div>
</template>

<script>

export default {
  props: {
    name: { type: String, required: true },
    portions: { type: String, required: true },
    cookMinutes: { type: String, required: true },
  },
};
</script>
