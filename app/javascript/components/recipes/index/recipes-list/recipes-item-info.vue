<template>
  <div class="flex flex-col items-start p-0 static w-auto h-14">
    <div class="flex-none order-0 flex-grow-0 mx-2.5">
      <div class="static w-auto h-6 not-italic text-lg text-black font-bold">
        {{ recipeName }}
      </div>

      <div class="p-0 static w-auto h-5 left-0">
        <div class="flex flex-row order-1 flex-grow-0 my-2.5 mx-0">
          <div class="flex items-center w-auto h-6 flex-grow-0 mr-2">
            <div class="mr-2">
              <img
                class="h-5 w-5 text-white"
                svg-inline
                src="../../../../../assets/images/chart-pie-svg.svg"
              >
            </div>
            <div class="w-auto h-6">
              {{ recipePortions + " porcion(es)" }}
            </div>
          </div>

          <div class="flex items-center w-auto h-6 flex-grow-0">
            <div class="mr-2">
              <img
                class="h-5 w-5 text-white"
                svg-inline
                src="../../../../../assets/images/clock-svg.svg"
              >
            </div>
            <div class="w-auto h-6">
              {{ recipeMinutes + " minuto(s)" }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipeName: { type: String, required: true },
    recipePortions: { type: Number, required: true },
    recipeMinutes: { type: Number, required: true },
  },
};
</script>
