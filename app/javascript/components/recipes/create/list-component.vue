<template>
<div>

  <div 
      v-for="element in elements"
      :key="element"
      :svg="svg">
    <container
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
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Object, required: true },
    svg: { type: Object, required: true },
    placeholder: { type: String, required: true },
  },
}
</script>
