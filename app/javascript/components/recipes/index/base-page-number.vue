<template>
  <span
    class="static w-6 h-7 font-sans not-italic font-normal text-2xl text-black  bg-blend-normal"
  >
    <span class="flex-none order-5 flex-grow-0 my-0 mx-4">
      {{ number }}
    </span>
  </span>
</template>

<script>
export default {
  props: {
    number: { type: String, required: true },
  },
};
</script>
