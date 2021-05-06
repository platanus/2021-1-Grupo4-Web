<template>
  <div>
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
    <container
      v-if="input"
      text="Costo total"
      :svg="{}"
      :input="false"
      :color="false"
    /> 

    <base-button
        :elements="{
        placeholder: 'Buscar mas ingredientes',
        color: 'bg-white hover:bg-gray-300 text-black'
      }"
      @click="search"
    />
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Array, required: true },
    svg: { type: Object, required: true },
    placeholder: { type: String, required: true },
    input: { type: Boolean, required: true },
  },
  data() {
    return {
      par: false,
    }
  },
  methods: {
    search() {
      return null;
    },
    color() {
      this.par = !this.par
      return this.par;
    },
  },
}
</script>
