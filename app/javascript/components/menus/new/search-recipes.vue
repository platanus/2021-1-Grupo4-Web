<template>
  <div class="flex items-left w-full mb-5 items-center justify-between">
    <input
      class="flex py-2 px-5 w-3/5 h-16 bg-white border-2 border-gray-500 rounded items-center self-stretch flex-grow-0"
      :placeholder="$t('msg.menus.searchRecipes')"
    >
    <button class="flex items-center justify-between h-7 py-1 px-3 min-w-min bg-yellow-500 rounded flex-grow-0">
      {{ $t('msg.menus.portions') }}
      <img
        svg-inline
        src="../../../../assets/images/chevron-down-svg.svg"
        class="w-5 h-5 text-yellow-700"
      >
    </button>
    <button class="flex items-center justify-between h-7 py-1 px-3 min-w-min bg-yellow-500 rounded flex-grow-0">
      {{ $t('msg.menus.price') }}
      <img
        svg-inline
        src="../../../../assets/images/chevron-down-svg.svg"
        class="w-5 h-5 text-yellow-700"
      >
    </button>
  </div>
</template>

<script>
export default {

};
</script>
