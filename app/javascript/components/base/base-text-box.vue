<template>
  <div>
    <textarea
      :id="tid"
      :placeholder="placeholder"
      :value="value"
      class="resize-y border-2 rounded-md border-gray-300 w-full my-4 p-4"
    />
  </div>
</template>

<script>
export default {
  props: {
    placeholder: { type: String, default: () => ('') },
    value: { type: String, default: () => ('') },
    tid: { type: String, default: () => ('textarea') },
  },
};
</script>
