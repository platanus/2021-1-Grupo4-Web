<template>
  <div class="flex flex-col">
    <div class="flex flex-row justify-between items-center h-8 order-0 flex-grow-0 mt-1 mb-4">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.create') }}
      </div>
    </div>
    <div class="flex">
      <!-- creador menu -->
      <div class="flex flex-col items-start w-4/6 h-auto bg-white flex-grow-0 mr-5 p-10">
        <information-menu />
        <div class="min-w-min font-hind font-normal text-base text-black flex-grow-0 mb-5">
          {{ $t('msg.menus.addRecipes') }}
        </div>
        <search-recipes />
        <available-recipes />
      </div>
      <!-- recetas seleccionadas -->
      <div class="flex flex-col items-start w-2/6 h-auto bg-white flex-grow-0 py-4 px-3">
        <div class="w-auto h-10 flex-grow-0 py-2 px-3 mb-2 font-hind font-bold text-base text-black">
          {{ $t('msg.menus.addRecipes') }}
        </div>
        <selected-recipes />
      </div>
    </div>
  </div>
</template>

<script>
export default {

};
</script>
