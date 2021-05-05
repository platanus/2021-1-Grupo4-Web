<template>
  <div>

    <div 
        v-for="element in elements"
        :key="element"
    >
      <container
        :text="element"
        :svg="svg"
        :input="false"
        :color="color()"
      />
    </div>
      <container
        text="Costo total"
        :svg="{}"
        :input="false"
        color="gray"
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
      par: 'gray',
    }
  },
  methods: {
    search() {
      return null;
    }
  },
  computed: {
    color() {
      if (this.par === 'white') {
        this.par = 'gray';
      }
      else {
        this.par = 'white';
      }
      return this.par;
    },
  },
}
</script>
