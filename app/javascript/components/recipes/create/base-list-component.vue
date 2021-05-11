<template>
  <div>
    <h2 class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
      {{ placeholder }}
    </h2>
    <div v-if="!drag">
      <div
        v-for="element in elements"
        :key="element"
      >
        <container
          :text="element"
          :svg="svg"
          :input="input"
          :color="color()"
        />
      </div>
    </div>

    <div v-if="input">
      <container
        text="Costo total"
        :svg="{}"
        :input="false"
        :color="false"
        class="my-4"
      />

      <base-button
        :elements="{
          placeholder: 'Buscar mas ingredientes',
          color: 'bg-white hover:bg-gray-300 text-black'
        }"
        @click="search"
        class="w-full"
      />
    </div>

    <div
      v-if="drag"
    >
      <drag-and-drop
        :elements="elements"
      />

      <text-box
        placeholder="Paso de la receta..."
      />

      <base-button
        :elements="{
          placeholder: 'Agregar paso',
          color: 'bg-white hover:bg-gray-300 text-black'
        }"
        @click="addStep"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Array, required: true },
    svg: { type: Object, required: true },
    placeholder: { type: String, required: true },
    input: { type: Boolean, required: true },
    drag: { type: Boolean, required: true },
  },
  data() {
    return {
      par: false,
    };
  },
  methods: {
    search() {
      return null;
    },
    color() {
      this.par = !this.par;

      return this.par;
    },
    addStep() {
      return null;
    },
  },
};
</script>
