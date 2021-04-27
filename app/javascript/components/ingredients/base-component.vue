/* eslint-disable no-console */
<template>
  <div>
    <!--Title-->
    <h2 class="text-4xl">
      Ingredientes
    </h2>

    <!--SearchBar y Button-->
    <div class="flex items-center">
      <search
        :ingredient="{ tipo: 'ingrediente' }"
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
      v-if="showingAdd"
      title="Agregar Ingrediente"
      ok-button-label="Agregar"
      cancel-button-label="Cancelar"
    >
      <ingredients-form
        :units="['Kg','Litro']"
        :edit-mode="false"
      />
    </base-modal>

    <!--EditModal-->
    <base-modal
      @ok="editIngredient"
      @cancel="toggleEditModal"
      v-if="showingEdit"
      title="Editar Ingrediente"
      ok-button-label="Guardar"
      cancel-button-label="Cancelar"
    >
      <ingredients-form
        :units="['Kg','Litro']"
        :edit-mode="true"
      />
    </base-modal>

    <!--DeleteModal-->
    <base-modal
      @ok="deleteIngredient"
      @cancel="toggleDelModal"
      v-if="showingDel"
      title="Eliminar Ingrediente"
      ok-button-label="Sí, Eliminar"
      cancel-button-label="Cancelar"
    >
      <p>Estás seguro que deseas eliminar este ingrediente?</p>
    </base-modal>
  </div>
</template>

<script>
import Search from '../base/base-search-component.vue';
import BaseButton from '../base/base-button-component.vue';
import BaseTable from '../base/base-table-component.vue';
import BaseModal from '../base/base-modal-component.vue';
import IngredientsForm from './base-form-component';

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
  data() {
    return {
      showingAdd: false,
      showingEdit: false,
      showingDel: false,
    };
  },
  methods: {
    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
    },
    toggleEditModal() {
      this.showingEdit = !this.showingEdit;
    },
    toggleDelModal() {
      this.showingDel = !this.showingDel;
    },
    addIngredient() {
      this.showingAdd = !this.showingAdd;
    },
    editIngredient() {
      this.showingEdit = !this.showingEdit;
    },
    deleteIngredient() {
      this.showingDel = !this.showingDel;
    },
  },
};
</script>
