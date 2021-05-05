<template>
  <div>
    <img 
      
    >
    <input-form
      v-if="input"
      id="grams"
      type="text"
      placeholder="Hay que arreglar el value"
      value=""
    />
  </div>
</template>

<script>
export default {
  props: {
    key: { type: String, required: true },
    input: { type: Boolean, required: true },
    svg: { type: Object, required: true },
  },
}
</script>
