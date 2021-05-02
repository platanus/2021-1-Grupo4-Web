<template>
  <div>
    <container
      v-for="element in elements"
      :key="element"
    />

    <container
        key="Costo total"
    /> 

    <base-button
        :elements="{
        placeholder: 'Buscar mas ingredientes',
        color: 'bg-white hover:bg-gray-300 text-black'
      }"
      @click="create"
    />
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Object, required: true },
  },
}
</script>
