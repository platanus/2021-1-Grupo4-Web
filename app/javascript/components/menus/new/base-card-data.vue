<template>
  <div class="flex flex-col items-start w-auto h-14 flex-grow-0 mx-0.5">
    <!-- name -->
    <div class="font-bold text-lg  text-black mb-0.5">
      Lasagna Vegetariana
    </div>
    <!-- info -->
    <div class="flex items-center h-5 w-auto flex-grow-0">
      <div class="flex items-center h-5 w-auto flex-grow-0 mr-2">
        <div class="w-3 h-3 flex-grow-0 mr-2">
          <img
            svg-inline
            src="../../../../assets/images/chart-pie-svg.svg"
            class="w-3 h-3 text-yellow-700"
          >
        </div>
        <div class="h-5 w-auto font-hind font-light text-sm text-black flex-grow-0">
          5 {{ $t('msg.menus.portions').toLowerCase() }}
        </div>
      </div>
      <div class="flex items-center h-5 w-auto flex-grow-0 mr-2">
        <div class="w-3 h-3 flex-grow-0 mr-2">
          <img
            svg-inline
            src="../../../../assets/images/dolar-svg.svg"
            class="w-3 h-3 text-yellow-700"
          >
        </div>
        <div class="h-5 w-auto font-hind font-light text-sm text-black flex-grow-0">
          $3.000 CLP
        </div>
      </div>
      <div class="flex items-center h-5 w-auto flex-grow-0">
        <div class="w-3 h-3 flex-grow-0 mr-2">
          <img
            svg-inline
            src="../../../../assets/images/clock-svg.svg"
            class="w-3 h-3 text-yellow-700"
          >
        </div>
        <div class="h-5 w-auto font-hind font-light text-sm text-black flex-grow-0">
          20 {{ $t('msg.menus.minutes') }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {

};
</script>
