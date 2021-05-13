<template>
  <div class="flex justify-between items-start w-48 self-stretch flex-grow-0 my-3">
    <div class="w-24 h-5 font-sans font-normal text-base text-black flex-grow-0">
      {{ ingredient.name }}
    </div>
    <div class="w-9 h-5 font-sans font-normal text-base text-black flex-grow-0">
      {{ ingredient.quantity }} {{ ingredient.measure }}
    </div>
  </div>
</template>

<script>

export default {
  props: {
    ingredient: { type: Object, required: true },
  },
};
</script>
