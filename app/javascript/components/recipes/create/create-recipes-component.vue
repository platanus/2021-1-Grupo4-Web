<template>
  <div>
    <!-- Title -->
    <div>
      <a href="/recipes">
        <img
          svg-inline
          src="../../../../assets/images/left-arrow-svg.svg"
          class="inline-block object-center h-8 w-8"
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
          :elements="getIngredients"
          :svg="{sixdots: false, cancel: true, menu_recipe: false, dropdown: false}"
          :input="true"
        />
      </div>
      <div class="col-span-2">
        <list
          placeholder="Pasos"
          :elements="getSteps"
          :svg="{sixdots: true, cancel: false, menu_recipe: true, dropdown: true}"
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
  </div>
</template>

<script>
export default {
  props: {
    objects: { type: Array, required: true }
  },
  methods: {
    create() {
      return null
    },
  },
  computed: {
    getSteps() {
      let steps = [this.objects[this.objects.length - 1]];
      const parsedSteps = JSON.parse(steps).instructions;
      let new_steps = parsedSteps.split('\n');
      return new_steps;
    },
    getIngredients() {
      let new_array = []
      for (let i = 0; i < this.objects.length - 1; i++) {
        new_array.push(this.objects[i]);
      }
      return new_array
    },
  },
};
</script>
