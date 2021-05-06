<template>
  <div class="flex flex-col justify-center items-end p-6 w-72 h-60 relative">
    <!-- title -->
    <div class="w-60 h-7 font-sans font-normal not-italic text-2xl text-black order-0 self-stretch flex-grow-0 my-4">
      {{ title }}
    </div>
    <!-- text-field -->
    <input
      class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded order-1 flex-grow-0 my-1"
      placeholder="max"
    >
    <input
      class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded order-1 flex-grow-0 my-1"
      placeholder="min"
    >
    <div
      class="w-12 h-5 font-sans font-normal not-italic text-base text-blue-700 underline order-3 flex-grow-0 my-1"
      @click="ok"
    >
      Aplicar
    </div>
  </div>
</template>

<script>

export default {
  props: {
    title: { type: String, required: true },
    max: { type: String, required: true },
    min: { type: String, required: true },
  },
  methods: {
    ok() {
      this.$emit('ok');
    },
    cancel() {
      this.$emit('cancel');
    },
  },
};
</script>
