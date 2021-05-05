<template>
  <div>
    <div class="w-72 h-20 grid grid-cols-4 items-center justify-items-center" :class="color ? 'bg-white' : 'bg-gray-100'">
      <!--div class="justify-self-start">
        <img 
          v-if="svg.sixdots"
          src="../../../../assets/images/menu-recipe-svg.svg"
        >
      </div-->
      <div>
        
        <input
          class="w-16 h-12 self-center justify-self-center bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none"
          v-if="input"
          id="grams"
          type="text"
          placeholder="Hay que arreglar el value"
          value=""
        >
          
      </div>
      <div>
        <span> {{ JSON.parse(text).measure }}</span>
      </div>  
      <div>
        <span> {{ JSON.parse(text).name }}</span>
      </div>  
      <div>
        <img 
          class="w-4 h-4 justify-self-end" 
          v-if="svg.cancel"
          src="../../../../assets/images/cancel-svg.svg"
        >
      </div>
    </div>

  </div>
</template>

<script>
export default {
  props: {
    text: { type: String, required: true },
    input: { type: Boolean, required: true },
    svg: { type: Object, required: true },
    color: { type: Boolean, required: true },
  },
  computed: {
    parsedElements() {
      const parsedElements = this.body.map((element) => JSON.parse(element));

      return parsedElements;
    },

  },
}
</script>
