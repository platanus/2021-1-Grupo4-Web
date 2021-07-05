<template>
  <div
    class="flex h-20 w-20"
    :class="active ? 'bg-yellow-500' : 'bg-gray-800 hover:bg-gray-600'"
    @mouseover="mouseOver"
    @mouseleave="notMouseOver"
  >
    <button
      @click="clickButton"
      class="focus:outline-none w-full"
    >
      <div class="flex flex-row justify-center p-2">
        <img
          class="h-12 w-12"
          svg-inline
          :src="require(`./../../../assets/images/${imgSrc}`)"
        >
      </div>
    </button>
    <div
      v-if="showLabel"
      class="flex items-center z-50 pl-4 -mr-40 w-40 font-bold text-xl text-white"
      :class="active ? 'bg-yellow-500' : 'bg-gray-600'"
    >
      {{ label }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    label: { type: String, required: true },
    active: { type: Boolean, required: true },
    imgSrc: { type: String, required: true },
  },
  data() {
    return {
      showLabel: false,
    };
  },
  methods: {
    clickButton() {
      this.$emit('click', this.label);
    },
    mouseOver() {
      this.showLabel = true;
    },
    notMouseOver() {
      this.showLabel = false;
    },
  },
};
</script>
