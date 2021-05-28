<template>
  <p class="ml-2 font-medium">
    {{ unitPrice | currency }}
  </p>
</template>

<script>
export default {
  props: {
    ingredient: { type: Object, required: true },
  },

  computed: {
    unitPrice() {
      const decimals = 2;

      return (this.ingredient.price / this.ingredient.quantity).toFixed(decimals);
    },
  },
};
</script>
