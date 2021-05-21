<template>
  <div class="flex items-center mr-4">
    <img
      svg-inline
      src="../../../../assets/images/recipe.jpg"
      class="w-20 h-20 text-yellow-700"
    >
    <div>
      <p class="py-2 px-3 font-medium">
        {{ recipe }}
      </p>
      <div>
        <p class="py-2 px-3 text-xs inline-block">
          XX porciones
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          $XX.XXX CLP
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          XX minutos
        </p>
      </div>
    </div>
    <div class="">
      <input
        type="checkbox"
        class="form-checkbox h-5 w-5 color-yellow-500"
        checked
      >
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipe: { type: String, required: true },
  },

};
</script>
