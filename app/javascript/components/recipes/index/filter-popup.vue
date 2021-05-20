<template>
  <div class="fixed z-10 inset-0 overflow-y-auto">
    <div
      class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
      aria-hidden="true"
    />
    <div class="flex flex-col justify-center items-end p-6 w-72 h-60 mt-36 relative bg-white m-auto">
      <!-- title -->
      <div class="w-60 h-7 font-sans font-normal not-italic text-2xl text-black self-stretch flex-grow-0 mb-4">
        {{ title }}
      </div>
      <!-- text-field -->
      <input
        class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border roundedflex-grow-0 my-1"
        :placeholder="max"
      >
      <input
        class="px-4 w-60 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
        :placeholder="min"
      >
      <div class="flex items-start w-auto h-5 flex-grow-0 my-4">
        <div
          class="w-24 h-5 font-sans font-normal not-italic text-base text-gray-400 underline flex-grow-0 my-1"
          @click="ok"
        >
          {{ $t('msg.recipes.filter.delete') }}
        </div>
        <div
          class="w-12 h-5 font-sans font-normal not-italic text-base text-blue-700 underline flex-grow-0 my-1"
          @click="ok"
        >
          {{ $t('msg.recipes.filter.aply') }}
        </div>
      </div>
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
