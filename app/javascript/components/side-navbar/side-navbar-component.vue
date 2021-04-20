<template>
  <div class="flex flex-col items-start pt-0 pl-0 pr-0 pb-8 absolute w-64 h-screen left-0 top-16 bg-gray-800">
    <item />
    <item />
    <item />
  </div>
</template>

<script>

import Item from './side-navbar-item-component.vue';

export default {
  components: {
    Item,
  },
  setup() {
    return (null);
  },
};
</script>
