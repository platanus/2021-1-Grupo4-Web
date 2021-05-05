<template>
  <div>
    <!-- Title -->
    <h2>(Atras) Crear Receta</h2>

    <p>Datos básicos</p>

    <div class="flex space-x-4">
      <search
        placeholder="Nombre"
        class="flex-2"
      />
      <search
        placeholder="Porciones"
        class="flex-1"
      />
      <search
        placeholder="Tiempo de preparación"
        class="flex-1"
      />
    </div>

    <div>
      <list
        placeholder="Ingredientes"
        :elements="objects"
        :svg="{sixdots: false}"
        :input="true"
      />
    <p>{{objects}}</p>
      <list
        placeholder="Pasos"
        :elements="objects"
        :svg="{sixdots: true}"
        :input="false"
      />
    </div>

    <base-button
      :elements="{
        placeholder: 'Crear receta',
        color: 'bg-white hover:bg-gray-300 text-black'
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
};
</script>
