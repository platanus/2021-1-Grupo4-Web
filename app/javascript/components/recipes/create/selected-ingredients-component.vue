<template>
  <div class="flex w-80 flex-col">
    <span class="flex content-center justify-center">Ingredientes seleccionados</span>
    <div class="flex p-4 grid grid-cols-2 items-center justify-between "
      v-for="element in parsedElements"
      :key="element.id"
      :class="color() ? 'bg-white' : 'bg-gray-100'"
    >
      <span class="flex content-center justify-center">
        {{ element.name }}
      </span>
      <span class="flex content-center justify-end">
        x
      </span>
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
  computed: {
    parsedElements() {
      const parsedElements = this.elements.map((element) => JSON.parse(element));
      return parsedElements;
    },

  },
}
</script>
