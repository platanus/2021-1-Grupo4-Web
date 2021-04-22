<template>
  <div class="flex flex-col items-start pt-0 pl-0 pr-0 pb-8 absolute w-64 h-screen left-0 top-16 bg-gray-800">
    <div v-for="option in options.elements">
     <item v-if="options.active_element===option" :option="option" :active="true" />
      <item v-else :option="option" :active="false" />
    </div>
  </div>
</template>

<script>

import Item from './side-navbar-item-component.vue';

export default {
  components: {
    Item,
  },

  props: {
    options: {type: Object, required: true},
  },

  setup() {
    return (null);
  },
};
</script>
