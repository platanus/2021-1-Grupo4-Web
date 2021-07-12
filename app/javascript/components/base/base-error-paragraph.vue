<template>
  <p
    v-if="errors.name"
    class="mt-2 ml-1 text-xs text-red-400"
  >
    {{ $t(`msg.${msgError}`) }}
  </p>
</template>

<script>
export default {
  props: {
    msgError: { type: String, required: true },
  },
};
</script>
