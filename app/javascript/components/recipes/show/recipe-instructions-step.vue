<template>
  <div class="flex items-start py-2 w-auto h-auto flex-grow-0 border border-gray-300 w-full p-4">
    <div class="w-6 h-6 p-3 flex items-center justify-center flex-grow-0 mr-3 rounded-full bg-yellow-500 font-sans font-normal text-white text-xs">
      {{ stepNumber }}
    </div>
    <div class="w-auto h-auto font-sans font-normal text-base text-black flex-grow text-justify">
      {{ step.description }}
    </div>
  </div>
</template>

<script>

export default {
  props: {
    step: { type: Object, required: true },
    stepNumber: { type: Number, required: true },
  },
};
</script>
