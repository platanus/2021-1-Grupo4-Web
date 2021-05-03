<template>
  <div>
    <div class="flex flex-row justify-between items-center p-0 static h-8 flex-none order-0 flex-grow-0 mt-1 mb-4">
      <div class="text-4xl flex-none order-0 flex-grow-0">
        Recetas
      </div>
      <span class="flex flex-row justify-center items-center px-3 h-8 bg-blue-700 rounded flex-none order-1 flex-grow-0 text-white">
        Agregar receta
      </span>
    </div>
    <search-recipe />
    <recipes :allrecipes="recipes" />
    <pagination />
  </div>
</template>

<script>
export default {
  props: {
    recipes: { type: Array, required: true },
  },
};
</script>
