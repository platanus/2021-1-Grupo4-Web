<template>
  <button
    @click="clickButton"
  >
    + 
  </button>
</template>

<script>
export default {
  props: {
    object: {type: Object, required:true}
  },
  data() {
    return {
    }
  },
  methods: {
    clickButton() {
      this.$emit('add-ingredient', this.object);
    },
  },
}
</script>
