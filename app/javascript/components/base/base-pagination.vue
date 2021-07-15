<template>
  <div
    class="flex w-90 justify-center m-2"
    v-if="finalPage != 1"
  >
    <button
      class="focus:outline-none m-2"
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
      class="focus:outline-none m-2 disabled:opacity-50 ..."
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
      v-if="1 < shownPages[0]"
    >
      <button
        class="focus:outline-none w-5 m-2"
        @click="changePage(1)"
      >
        {{ 1 }}
      </button>
      ...
    </div>
    <div
      v-for="index in shownPages"
      :key="index"
    >
      <button
        class="text-yellow-500 focus:outline-none w-5 m-2"
        v-if="index === currentPage"
        @click="changePage(index)"
      >
        {{ index }}
      </button>
      <button
        class="focus:outline-none w-5 m-2"
        v-else
        @click="changePage(index)"
      >
        {{ index }}
      </button>
    </div>
    <div
      v-if="finalPage > shownPages[shownPages.length - 1]"
    >
      ...
      <button
        class="focus:outline-none w-5 m-2"
        @click="changePage(finalPage)"
      >
        {{ finalPage }}
      </button>
    </div>
    <button
      class="focus:outline-none m-2"
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
      class="focus:outline-none disabled:opacity-50 m-2"
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
  },
  computed: {
    shownPages() {
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
