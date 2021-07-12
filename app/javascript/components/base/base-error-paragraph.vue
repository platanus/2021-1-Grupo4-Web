<template>
  <p
    v-if="msgError"
    class="my-2 ml-1 text-xs text-red-400"
  >
    {{ $t(`msg.${msgError}`) }}
  </p>
</template>

<script>
export default {
  props: {
    msgError: { type: String, default: '' },
  },
};
</script>
