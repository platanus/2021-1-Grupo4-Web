<template>
  <div class="static w-16 pl-2 items-center left-16 not-italic font-normal text-xl text-white">
    {{ label }}
  </div>
</template>

<script>
export default {
  props: {
    label: { type: String, required: true},
    },

  setup() {
    return (null);
  },
};
</script>
