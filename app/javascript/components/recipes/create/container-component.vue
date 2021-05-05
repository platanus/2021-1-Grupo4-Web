<template>
  <div
  >
    <div>
      <img 
        v-if="svg.sixdots"
        src="../../../assets/images/menu-recipe-svg.sv"
      >
      <p>{{ text }}</p>
      <input-form
        v-if="input"
        id="grams"
        type="text"
        placeholder="Hay que arreglar el value"
        value=""
      />
    </div

  </div>
</template>

<script>
export default {
  props: {
    text: { type: String, required: true },
    input: { type: Boolean, required: true },
    svg: { type: Object, required: true },
    color: { type: String, required: true },
  },
}
</script>
