<template>
  <button
    class="mx-2 my-2 h-10 font-bold py-2 px-6 rounded shadow-md"
    :class="elements.color"
    @click="clickButton"
  >
    {{ elements.placeholder }}
  </button>
</template>

<script>
export default {
  props: {
    elements: { type: Object, required: true },
  },
  
  methods: {
    clickButton() {
      this.$emit('click');
    },
  },
};
</script>