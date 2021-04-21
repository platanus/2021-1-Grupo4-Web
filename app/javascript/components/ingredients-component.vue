<template>
  <div>
    <h2 class="text-4xl">Ingredientes</h2>

    <div class="flex items-center">
      <search
        :algo="{ tipo: 'ingrediente' }"
      />
      <base-button :elements="{ placeholder:'Agregar ingrediente' }" />
    </div>

    <!-- Componente tabla, con parametro de cuantas columnas hacer -->
  </div>
</template>

<script>
import Search from './search-component.vue';
import BaseButton from './base-button-component.vue';

export default {
  components: {
    Search,
    BaseButton,
  },
  props: {
    ingredients: { type: Object, required: true },
  },
};
</script>
