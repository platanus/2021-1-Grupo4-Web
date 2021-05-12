<template>
  <div class="flex flex-col items-center h-auto w-auto flex-grow-0">
    <div class="flex flex-col divide-y items-center h-auto w-auto flex-grow-0">
      <recipe-selected />
      <recipe-selected />
      <recipe-selected />
      <recipe-selected />
      <recipe-selected />
    </div>
    <div class="flex justify-end w-auto h-16 bg-white self-stretch flex-grow-0 py-5 font-hind font-bold text-base text-black">
      {{ $t('msg.menus.menuPrice') }}: $25.000
    </div>
    <div class="flex justify-end w-auto h-12 self-stretch flex-grow-0">
      <button class="py-1.5 px-10 bg-green-500 shadow-sm rounded-md font-hind font-normal text-base text-white">
        {{ $t('msg.menus.create') }}
      </button>
    </div>
  </div>
</template>

<script>
export default {

};
</script>
