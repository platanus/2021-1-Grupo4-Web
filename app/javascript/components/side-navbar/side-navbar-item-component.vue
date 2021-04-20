<template>
  <div class="flex flex-row items-center pt-1 pl-2 pb-1 pr-2 static w-64 h-16 left-0 top-32 bg-gray-800">
    <label-option />
  </div>
</template>

<script>

import LabelOption from './side-navbar-label-component.vue';

export default {
  components: {
    LabelOption,
  },
  setup() {
    return (null);
  },
};
</script>
