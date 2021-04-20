<template>
  <input
    type="search"
    placeholder="(inserte lupa) Buscar ingrediente..."
  >
</template>

<script>
export default {
  props: {
    algo: { type: Object, required: true },
  },
};
</script>
