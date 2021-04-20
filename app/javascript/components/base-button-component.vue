<template>
  <div>
    <button
      @click="addIngredient"
    >
      {{ elements.placeholder }}
    </button>
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Object, required: true },
  },
  methods: {
    addIngredients() {
      console.log('boton apretado');
    },
  },
};
</script>
