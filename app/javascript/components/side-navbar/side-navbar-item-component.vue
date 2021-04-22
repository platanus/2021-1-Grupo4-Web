<template>
  <div class="flex flex-row items-center pt-1 pl-10 pb-1 pr-2 static w-64 h-16 left-0 bg-black">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-white " viewBox="0 0 20 20" fill="currentColor">
      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd" />
    </svg>
    <label-option :label="option" />
  </div>
</template>

<script>

import LabelOption from './side-navbar-label-component.vue';

export default {
  props: {
    option: { type: String, required: true},
    },

  components: {
    LabelOption,
  },
  setup() {
    return (null);
  },
};
</script>
