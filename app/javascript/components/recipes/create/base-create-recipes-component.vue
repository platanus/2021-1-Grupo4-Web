/* eslint-disable linebreak-style */
<template>
  <div>
    <!-- Title -->
    <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-1">
      <div class="flex items-center">
        <a href="/recipes">
          <img
            class="h-6 w-6 text-white mx-2"
            svg-inline
            src="../../../../assets/images/arrow-left-svg.svg"
          >
        </a>
        <div class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
          Crear receta
        </div>
      </div>
    </div>

    <p>Datos básicos</p>

    <div class="grid grid-cols-4 gap-4">
      <search
        placeholder="Nombre"
        :search-icon="false"
        class="col-span-2 w-full"
      />
      <search
        placeholder="Porciones"
        :search-icon="false"
        class="w-full"
      />
      <search
        placeholder="Tiempo de preparación w-full"
        :search-icon="false"
        class="w-full"
      />
    </div>

    <div class="grid grid-cols-3 gap-4">
      <div>
        <list
          placeholder="Ingredientes"
          :elements="getIngredients"
          :svg="{sixdots: false, cancel: true, menu_recipe: false, dropdown: false}"
          :input="true"
          :drag="false"
        />
      </div>
      <div class="col-span-2">
        <list
          placeholder="Pasos"
          :elements="getSteps"
          :svg="{sixdots: true, cancel: false, menu_recipe: true, dropdown: true}"
          :input="false"
          :drag="true"
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
  </div>
</template>

<script>
export default {
  props: {
    objects: { type: Array, required: true },
  },
  methods: {
    create() {
      return null;
    },
  },
  computed: {
    getSteps() {
      const steps = [this.objects[this.objects.length - 1]];
      const parsedSteps = JSON.parse(steps).instructions;
      const newSteps = parsedSteps.split('\n');

      return newSteps;
    },
    getIngredients() {
      const newArray = [];
      for (let i = 0; i < this.objects.length - 1; i++) {
        newArray.push(this.objects[i]);
      }

      return newArray;
    },
  },
};
</script>
