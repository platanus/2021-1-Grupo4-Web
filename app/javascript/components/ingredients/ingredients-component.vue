<template>
  <div>
    <!--Title-->
    <h2 class="text-4xl">Ingredientes</h2>

    <!--SearchBar y Button-->
    <div class="flex items-center">
      <search
        :algo="{ tipo: 'ingrediente' }"
      />
      <base-button 
        :elements="{ placeholder:'Agregar ingrediente', color: 'bg-green-500 hover:bg-green-700 text-white' }"
        @click="toggleAddModal"
      />
    </div>

    <!--Table-->
    <div class="flex items-center">
      <base-table 
        :dots="true" 
        :table="{ header: Object.keys(JSON.parse(ingredients[0])), body: ingredients }"
        @edit="toggleEditModal"
        @del="toggleDelModal"
        />
    </div>

    <!--AddModal-->
    <base-modal
      @ok="addIngredient"
      @cancel="toggleAddModal" 
      v-if="showing_add"
      title="Agregar Ingrediente"
      okButtonLabel="Agregar"
      cancelButtonLabel="Cancelar"
    >
      <ingredients-form/>
    </base-modal>

    <!--EditModal-->
    <base-modal
      @ok="editIngredient"
      @cancel="toggleEditModal" 
      v-if="showing_edit"
      title="Editar Ingrediente"
      okButtonLabel="Guardar"
      cancelButtonLabel="Cancelar"
    >
      <ingredients-form/>
    </base-modal>

    <!--DeleteModal-->
    <base-modal
      @ok="deleteIngredient"
      @cancel="toggleDelModal" 
      v-if="showing_del"
      title="Eliminar Ingrediente"
      okButtonLabel="Sí, Eliminar"
      cancelButtonLabel="Cancelar"
    >
      <p>Estás segura de que deseas eliminar este ingrediente?</p>
    </base-modal>

  </div>
</template>

<script>
import Search from '../search-component.vue';
import BaseButton from '../base-button-component.vue';
import BaseTable from '../base-table/base-table-component.vue';
import BaseModal from '../base-modal-component.vue';
import IngredientsForm from  './ingredients-form-component';

export default {
  components: {
    Search,
    BaseButton,
    BaseTable,
    BaseModal,
    IngredientsForm,
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
      this.showing_add = !this.showing_add;
    },
    toggleEditModal() {
      this.showing_edit = !this.showing_edit;
    },
    toggleDelModal() {
      this.showing_del = !this.showing_del;
    },
    addIngredient(){
      this.showing_add = !this.showing_add;
      console.log("Agregar Ingrediente");
    },
    editIngredient(){
      this.showing_edit = !this.showing_edit;
      console.log("Editar Ingrediente");
    },
    deleteIngredient(){
      this.showing_del = !this.showing_del;
      console.log("Eliminar Ingrediente");
    },
  },
};
</script>
