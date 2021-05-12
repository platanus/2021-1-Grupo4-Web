<template>
  <div class="flex items-start bg-white border border-gray-500 self-stretch flex-grow-0">
    <!-- recipe photo -->
    <div class="w-20 h-20 flex-grow-0 bg-blue-100" />
    <!-- recipe data -->
    <div class="flex py-1 px-3 h-20 w-auto justify-between items-center flex-grow">
      <card-data />
      <button class="flex items-center py-1.5 px-10 w-32 h-11 bg-yellow-500 shadow-md rounded-md flex-grow-0 my-0.5">
        {{ $t('msg.add') }}
      </button>
    </div>
  </div>
</template>

<script>
import CardData from './base-card-data.vue';

export default {
  components: {
    CardData,
  },
};
</script>
