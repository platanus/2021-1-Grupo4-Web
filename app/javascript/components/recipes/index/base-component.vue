<template>
  <div>
    <div class="flex flex-row justify-between items-center p-0 static h-8 flex-none order-0 flex-grow-0 my-4">
      <h2 class="text-4xl flex-none order-0 flex-grow-0">
        Recetas
      </h2>
      <span class="flex flex-row justify-center items-center px-3 h-8 bg-blue-700 rounded flex-none order-1 flex-grow-0 m-0">
        Agregar receta
      </span>

    </div>
    <search-recipe />
    <recipes />
    <pagination />
  </div>
</template>

<script>
export default {

};
</script>
