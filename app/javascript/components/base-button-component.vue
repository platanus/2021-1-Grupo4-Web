<template>
    <button  
      class="mx-2 my-2 h-10 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
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
