<template>
  <div class="flex justify-between items-center w-48 self-stretch flex-grow-0 my-3">
    <div class="min-w-min h-5 font-sans font-normal text-base text-black flex-grow-0">
      {{ ingredient.name }}
    </div>
    <div class="w-9 font-sans text-base text-black truncate">
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
