<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        Editar {{ recipeId }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipeId: { type: Number, required: true },
  },

};
</script>
