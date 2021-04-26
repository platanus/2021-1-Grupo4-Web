<template>
  <div class="pt-3">
    <form class="w-full max-w-lg">
      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <input-form
            id="ingredient-name"
            type="text"
            placeholder="Nombre"
          />
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <input-form
            id="ingredient-amount"
            type="number"
            placeholder="Cantidad"
          />
        </div>
        <div class="relative">
          <select
            class="block appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none"
            id="ingredient-unit"
          >
            <option
              hidden
              selected
            >
              Unidad
            </option>
            <option v-for="unit in units">
              {{ unit }}
            </option>
          </select>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
            <svg
              class="fill-current h-4 w-4"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
            ><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
          </div>
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <input-form
            id="ingredient-price"
            type="number"
            placeholder="Precio"
          />
        </div>
      </div>
    </form>
  </div>
</template>

<script>
<<<<<<< HEAD
import InputForm from "./base-input-form.vue"
=======
import InputForm from './base-input-form.vue';

>>>>>>> 2a909cdad9edc0f0727fd437f24c679d516257ea
export default {
  props: {
    editMode: { type: Boolean, required: true },
    ingredientData: { type: Object },
    units: { type: Array, required: true },
  },
  components: {
<<<<<<< HEAD
    InputForm
  }
=======
    InputForm,
  },
>>>>>>> 2a909cdad9edc0f0727fd437f24c679d516257ea
};
</script>
