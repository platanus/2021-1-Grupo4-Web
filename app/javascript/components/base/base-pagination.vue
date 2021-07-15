<template>
  <div
    class="flex w-90 justify-end m-2"
    v-if="finalPage != 1"
  >
    <button
      class="focus:outline-none"
      v-if="currentPage != 1"
      @click="prev"
    >
      <img
        class="h-5 w-5 text-white"
        svg-inline
        src="../../../assets/images/keyboard-arrow-left-svg.svg"
      >
    </button>
    <button
      class="focus:outline-none disabled:opacity-50 ..."
      disabled
      v-else
    >
      <img
        class="h-5 w-5 text-white"
        svg-inline
        src="../../../assets/images/keyboard-arrow-left-svg.svg"
      >
    </button>
    <div
      v-for="index in getShownPages()"
      :key="index"
    >
      <button
        class="bg-yellow-500 focus:outline-none w-5"
        v-if="index === currentPage"
        @click="changePage(index)"
      >
        {{ index }}
      </button>
      <button
        class="focus:outline-none w-5"
        v-else
        @click="changePage(index)"
      >
        {{ index }}
      </button>
    </div>
    <button
      class="focus:outline-none"
      v-if="currentPage != finalPage"
      @click="next"
    >
      <img
        class="h-5 w-5 text-white"
        svg-inline
        src="../../../assets/images/keyboard-arrow-right-svg.svg"
      >
    </button>
    <button
      class="focus:outline-none disabled:opacity-50 ..."
      disabled
      v-else
    >
      <img
        class="h-5 w-5 text-white"
        svg-inline
        src="../../../assets/images/keyboard-arrow-right-svg.svg"
      >
    </button>
  </div>
</template>

<script>
export default {
  props: {
    finalPage: { type: Number, required: true },
    currentPage: { type: Number, required: true },
    pageSlots: { type: Number, default: 6 },
  },
  methods: {
    prev() {
      this.$emit('prev');
    },
    next() {
      this.$emit('next');
    },
    changePage(index) {
      this.$emit('change-page', index);
    },
    getShownPages() {
      const split = 2;
      let startAt;
      if (Math.floor(this.currentPage + this.pageSlots / split) > this.finalPage) {
        startAt = Math.max(this.finalPage - this.pageSlots + 1, 1);
      } else {
        startAt = Math.max(this.currentPage - Math.floor(this.pageSlots / split), 1);
      }

      return [...Array(Math.min(this.finalPage, this.pageSlots)).keys()].map(i => i + startAt);
    },
  },
};
</script>
