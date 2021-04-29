<template>
  <input
    class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
    :id="id"
    :type="type"
    :placeholder="placeholder"
    :value="value"
  >
</template>

<script>
export default {
  props: {
    id: { type: String, required: true },
    type: { type: String, required: true },
    placeholder: { type: String, required: true },
    value: { required: true},
  },
};
</script>
