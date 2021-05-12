<template>
  <div class="flex items-start justify-between min-w-full h-24 self-stretch flex-grow-0 mb-5">
    <!-- nombre -->
    <div class="flex flex-col items-start w-4/6 h-24 flex-grow-1 mr-5">
      <div class="w-auto h-6 font-hind font-normal text-base text-black self-stretch flex-grow-0 mb-1">
        {{ $t('msg.menus.menuName') }}
      </div>
      <input class="flex items-center py-2 px-5 w-auto h-16 bg-white border-2 border-gray-500 rounded self-stretch flex-grow-0">
    </div>
    <!-- Porciones-->
    <div class="flex flex-col items-start w-2/6 h-24 flex-grow-1">
      <div class="w-auto h-6 font-hind font-normal text-base text-black self-stretch flex-grow-0 mb-1">
        {{ $t('msg.menus.portions') }}
      </div>
      <input class="flex items-center py-2 px-5 w-auto h-16 bg-white border-2 border-gray-500 rounded self-stretch flex-grow-0">
    </div>
  </div>
</template>

<script>
export default {
};
</script>
