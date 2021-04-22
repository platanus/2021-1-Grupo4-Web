<template>
  <div>
    <h2 class="text-4xl">Ingredientes</h2>

    <div class="flex items-center">
      <search
        :algo="{ tipo: 'ingrediente' }"
      />
      <base-button 
        :elements="{ placeholder:'Agregar ingrediente', color: 'bg-green-500' }"
        @click="toggleAddModal"
      />
    </div>

    <div class="flex items-center">
      <base-table 
        :dots="true" 
        :table="{ header: Object.keys(JSON.parse(ingredients[0])), body: ingredients }"
        @edit="toggleEditModal"
        @del="toggleDelModal"
        />
    </div>

   
    <add-ingredient-modal 
      @cancel="toggleAddModal" 
      v-if="showing_add"
      :elements="{ kind: 'Agregar' }"
    />
    <add-ingredient-modal
      @cancel="toggleEditModal" 
      v-if="showing_edit"
      :elements="{ kind: 'Editar' }"
    />
    <add-ingredient-modal
      @cancel="toggleDelModal"
      v-if="showing_del"
      :elements="{ kind: 'Eliminar' }"
    />


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
      showing_add: false,
      showing_edit: false,
      showing_del: false,
    }
  },

  methods: {
    toggleAddModal() {
      console.log('Abrir modal');
      this.showing_add = !this.showing_add
    },
    toggleEditModal() {
      console.log('editar modal');
      this.showing_edit = !this.showing_edit;
    },
    toggleDelModal() {
      console.log('eliminar modal');
      this.showing_del = !this.showing_del;
    },
  },
};
</script>
