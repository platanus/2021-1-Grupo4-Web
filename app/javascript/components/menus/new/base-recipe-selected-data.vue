<template>
  <div class="flex justify-between items-center flex-grow p-2">
    <!-- ppal data -->
    <div class="flex flex-col items-start h-16 w-auto self-stretch flex-grow">
      <!-- recipe name -->
      <div class="w-auto h-6 font-hind font-medium text-base text-black flex-grow-0 my-0.5">
        Lasagna Vagetariana
      </div>
      <!-- recipe portions -->
      <div class="flex items-center w-auto h-4 flex-grow-0 mb-0.5">
        <div class="w-auto h-4 font-hind font-normal text-xs text-black flex-grow-0 mr-0.5">
          Porciones
        </div>
        <!-- botones e input -->
        <div class="flex items-center w-12 h-3 flex-grow-0">
          <!-- minus -->
          <div class="w-3 h-3 bg-gray-300 shadow-sm flex-grow-0 mr-0.5">
            <img
              svg-inline
              src="../../../../assets/images/minus-svg.svg"
              class="w-3 h-3"
            >
          </div>
          <input class="w-5 h-3 bg-white border border-gray-300 rounded-sm flex-grow-0 mr-0.5">
          <!-- plus -->
          <div class="w-3 h-3 bg-gray-300 shadow-sm flex-grow-0">
            <img
              svg-inline
              src="../../../../assets/images/plus-svg.svg"
              class="w-3 h-3"
            >
          </div>
        </div>
      </div>
    </div>
    <!-- price info and delete button -->
    <div class="flex flex-col justify-center items-end h-16 w-14 self-stretch flex-grow-0">
      <div class="w-3 h-3 bg-red-500 shadow-sm rounded-md flex-grow-0 my-1.5">
        <img
          svg-inline
          src="../../../../assets/images/cross-svg.svg"
          class="w-3 h-3 text-white"
        >
      </div>
      <div class="h-6 w-auto font-hind font-medium text-xs text-right text-back flex-grow-0 mb-1.5">
        $ 25.000
      </div>
    </div>
  </div>
</template>

<script>
export default {

};
</script>
