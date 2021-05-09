<template>
  <div class="flex flex-col">
    <div class="flex flex-row justify-between items-center h-8 order-0 flex-grow-0 mt-1 mb-4">
      <div class="text-4xl order-0 flex-grow-0">
        Crear Menú
        <!-- {{ $t('msg.recipes.title') }} -->
      </div>
    </div>
    <div class="flex">
      <!-- creador menu -->
      <div class="flex flex-col items-start w-4/6 h-auto bg-gray-100 flex-grow-0 mr-5 p-10">
        <information-menu />
        <div class="min-w-min font-hind font-normal text-base text-black flex-grow-0 mb-5">Agregar recetas</div>
        <search-recipes />
        <available-recipes />
      </div>
      <!-- recetas seleccionadas -->
      <div class="flex items-start w-2/6 h-auto bg-gray-100 flex-grow-0 py-4 px-3">
        hola
      </div>
    </div>
  </div>
</template>

<script>
export default {

};
</script>
