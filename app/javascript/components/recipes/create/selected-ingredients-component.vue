<template>
  <div class="flex w-80 flex-col">
    <span class="flex content-center justify-center">Ingredientes seleccionados</span>
    <div class="flex p-4 grid grid-cols-2 items-center justify-between "
      v-for="element in elements"
      :key="element.name"
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
    addIngredientKey: { type: Number, required: true }
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
