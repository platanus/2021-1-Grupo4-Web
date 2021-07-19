<template>
  <div
    v-if="variable"
    class="flex mt-4 w-max px-4 py-3 rounded relative"
    :class="success ? successClass : errorClass"
    role="alert"
  >
    <div>
      <span class="mr-2 block sm:inline">{{ $t(`msg.${alertName}`) }}</span>
    </div>
    <div
      class="m-auto cursor-pointer"
      @click="closeAlert"
    >
      <img
        svg-inline
        src="../../../assets/images/cancel-svg.svg"
        class="h-5 w-5 text-red-700"
      >
    </div>
  </div>
</template>

<script>
export default {
  props: {
    variable: { type: Boolean, required: true },
    success: { type: Boolean, required: true },
    alertName: { type: String, required: true },
  },
  data() {
    return {
      successClass: 'bg-green-50 border border-green-200 text-green-700',
      errorClass: 'bg-red-50 border border-red-200 text-red-700',

    };
  },

  methods: {
    closeAlert() {
      this.$emit('closeAlert', this.alertName);
    },
  },
};
</script>
