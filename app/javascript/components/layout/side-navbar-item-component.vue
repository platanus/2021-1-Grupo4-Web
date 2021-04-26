<template>
  <div>
    <button
      @click="clickButton"
      :class="active ? 'bg-yellow-500' : 'bg-gray-800 hover:bg-gray-600'"
    >
      <div class="flex flex-row items-center pt-1 pl-10 pb-1 pr-2 static w-64 h-16 left-0">
        <slot />
        <div class="static w-16 pl-2 items-center left-16 not-italic font-normal text-xl text-white">
          {{ label }}
        </div>
      </div>
    </button>
  </div>
</template>

<script>

export default {
  props: {
    label: { type: String, required: true },
    active: { type: Boolean, required: true },
  },

  methods: {
    clickButton() {
      this.$emit('click', this.label);
    },
  },
};
</script>
