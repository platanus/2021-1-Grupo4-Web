<template>
  <div class="p-4">
    <button
      @click="clickButton"
      class="focus:outline-none h-auto w-48 rounded-md"
      :class="active ? 'bg-yellow-500' : 'bg-gray-800 hover:bg-gray-600'"
    >
      <img
        v-if="imgSrc"
        class="h-28 w-28 pt-4 m-auto text-white"
        svg-inline
        :src="require(`./../../../assets/images/${imgSrc}`)"
      >
      <div class="items-center p-4 font-normal text-2xl text-white">
        {{ label }}
      </div>
    </button>
  </div>
</template>

<script>
export default {
  props: {
    label: { type: String, required: true },
    active: { type: Boolean, required: true },
    imgSrc: { type: String, required: true },
    link: { type: String, required: true },
  },
  methods: {
    clickButton() {
      window.location = this.link;
    },
  },
};
</script>
