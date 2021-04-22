<template>
<div class="fixed z-10 inset-0 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
  <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
    <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
    <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
    <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
      <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
        <div class="sm:flex sm:items-start">
          <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
            
            <!--Título-->
            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
              {{ elements.kind }} Ingrediente
            </h3>

            <!--Contenido-->
            <div class="mt-2">
              <p class="text-sm text-gray-500">
                Aquí va el form
              </p>
            </div>

          </div>
        </div>
      </div>

      <!--Parte de abajo donde van los botones-->
      <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
        <base-button 
        :elements="{ placeholder:'Agregar ingrediente', color: 'bg-green-500'}"
        @click="addIngredient"
        />

        <base-button
        :elements="{ placeholder:'Cancelar', color: 'bg-gray-400'}"
        @click="cancel"
        />
      </div>

    </div>
  </div>
</div>


</template>

<script>
import BaseButton from './base-button-component.vue';

export default {
components: {
    BaseButton,
},
props: {
  elements: {
    type: Object, required: true
  },
},
methods:{
    addIngredient(){
        console.log("Agregar Ingrediente");
    },

    cancel(){
        console.log("Cancelar");
        this.$emit('cancel');
    },
}
}
</script>