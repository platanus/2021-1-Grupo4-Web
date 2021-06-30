<template>
  <button
    class="font-bold py-2 px-6 rounded shadow-md w-full h-auto focus:outline-none"
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
