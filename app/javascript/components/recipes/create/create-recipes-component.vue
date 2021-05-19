<template>
  <div>
    <!-- Title -->
    <div>
      <a href="/recipes">
        <img
          svg-inline
          src="../../../../assets/images/left-arrow-svg.svg"
          class="inline-block align-middle h-8 w-8"
        >
      </a>
      <h2 class="inline-block text-3xl h-8">
        Crear Receta
      </h2>
    </div>

    <p>Datos básicos</p>

    <div class="flex space-x-4">
      <search
        placeholder="Nombre"
        :searchIcon="false"
        class="flex-2"
      />
      <search
        placeholder="Porciones"
        :searchIcon="false"
        class="flex-1"
      />
      <search
        placeholder="Tiempo de preparación"
        :searchIcon="false"
        class="flex-1"
      />
    </div>

    <div class="grid grid-cols-3 gap-4">
      <div>
        <list
          placeholder="Ingredientes"
          :elements="objects"
          :svg="{sixdots: false, cancel: true, menu_recipe: false}"
          :input="true"
        />
      </div>
      <div class="col-span-2">
        <list
          placeholder="Pasos"
          :elements="objects"
          :svg="{sixdots: true, cancel: false, menu_recipe: true}"
          :input="false"
        />
      </div>
    </div>

    <base-button
      :elements="{
        placeholder: 'Crear receta',
        color: 'bg-blue-600 text-white hover:bg-white text-blue-600'
      }"
      @click="create"
    />
    
    <base-modal
      @ok="toggleAddIngredientModal"
      @cancel="toggleAddIngredientModal"
      v-if="showingAddIngredientModal"
      :title="$t('msg.ingredients.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <div class="flex f-row w-full">
        <div class="mr-10">
          <search-ingredient-list 
            :ingredients="objects"
            @addIngredient="addIngredient"
          />
        </div>
        <selected-ingredients 
          :elements="selectedIngredients"
          :svg="{sixdots: true, cancel: false, menu_recipe: true}"
          :input="false"
          :placeholder="'------'"
          :addIngredientKey="addIngredientKey"
        /> 
      </div>
    </base-modal>
  </div>
</template>

<script>
import BaseModalComponent from '../../base/base-modal-component.vue';
import searchIngredientListComponent from './search-ingredient-list-component.vue';
export default {
  components: { searchIngredientListComponent, BaseModalComponent },
  props: {
    objects: { type: Array, required: true }
  },
  data() {
    return {
      steps: this.objects,
      showingAddIngredientModal: true,
      selectedIngredients: [],
      addIngredientKey: 0,
    }
  },
  methods: {
    create() {
      return null
    },
    toggleAddIngredientModal(){
      this.showingAddIngredientModal = !this.showingAddIngredientModal;
    },
    addIngredient(object){
     this.selectedIngredients.push(object);
     this.addIngredientKey += 1;
     alert(this.addIngredientKey);
    }
  },
  computed: {
    getSteps() {
      let steps = this.elements[this.elements.length - 1];
      return steps
    },
    getIngredients() {
      let new_array = []
      for (let i = 0; i < arr.length - 1; i++) {
        console.log('hola')
        
      }
    },
  },

};
</script>
