<template>
  <div>
    <h2 class="text-4xl">Ingredientes</h2>

    <div class="flex items-center">
      <search
        :algo="{ tipo: 'ingrediente' }"
      />
      <base-button 
        :elements="{ placeholder:'Agregar ingrediente' }"
        @click="addIngredient"
      />
    </div>

    <div class="flex items-center">
      <base-table :dots="true" :table="{ header: Object.keys(JSON.parse(ingredients[0])), body: ingredients }"/>
    </div>
    




  </div>
</template>

<script>
import Search from './search-component.vue';
import BaseButton from './base-button-component.vue';
import BaseTable from './base-table/base-table-component.vue';

export default {
  components: {
    Search,
    BaseButton,
    BaseTable,
  },
  props: {
    ingredients: { type: Array, required: true },
  },
  methods: {
    addIngredient() {
      console.log('Agregar Ingrediente');
    },
  },
};
</script>
