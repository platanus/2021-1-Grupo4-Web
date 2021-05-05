<template>
  <div>
    <img 
      v-if="svg.sixdots"
      src='../../../assets/images/menu-recipe-svg.svg'
    >
    <!--<p>{{key}}</p>-->
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
