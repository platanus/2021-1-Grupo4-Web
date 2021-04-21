<template>
  <div>
    <h2 class="text-4xl">Ingredientes</h2>

    <div class="flex items-center">
      <search
        :algo="{ tipo: 'ingrediente' }"
      />
      <base-button 
        :elements="{ placeholder:'Agregar ingrediente', color: 'bg-green-500' }"
        @click="toggleModal"
      />
    </div>

    <div class="flex items-center">
      <base-table :dots="true" :table="{ header: Object.keys(JSON.parse(ingredients[0])), body: ingredients }"/>
    </div>

    <div v-if="showing">
      <add-ingredient-modal/>
    </div>

  </div>
</template>

<script>
import Search from './search-component.vue';
import BaseButton from './base-button-component.vue';
import BaseTable from './base-table/base-table-component.vue';
import AddIngredientModal from './add-ingredient-component.vue';
export default {
  components: {
    Search,
    BaseButton,
    BaseTable,
    AddIngredientModal
  },

  props: {
    ingredients: { type: Array, required: true },
  },

  data(){
    return {
      showing: false
    }
  },

  methods: {
    toggleModal() {
      console.log('Abrir modal');
      this.showing = !this.showing
    },
  },
};
</script>
