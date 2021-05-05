<template>
  <div>
    <!--Title-->
    <div class="flex flex-row justify-between items-center w-auto h-8 order-0 self-stretch flex-grow-0  my-1">
      <div class="flex flex-row items-center">
        <img
          class="h-6 w-6 text-white mx-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
        <div class="h-7 font-sans font-normal not-italic text-2xl text-black order-1 flex-grow-1 mx-2">
          Lazaña Vegetariana
        </div>
      </div>
      <div class="flex flex-row items-center">
        <div class="flex flex-row justify-center items-center px-3 w-24 h-8 bg-white border-2 border-solid border-purple-600 box-border rounded order-2 flex-grow-0 mx-2 text-purple-600">
          {{ $t('msg.recipes.delete') }}
        </div>
        <div class="flex flex-row justify-center items-center px-3 w-24 h-8 bg-white border-2 border-solid border-blue-700 box-border rounded order-2 flex-grow-0 mx-2 text-blue-700">
          {{ $t('msg.recipes.edit') }}
        </div>
      </div>
    </div>
    <!--Info-->
    <recipe-info />
    <!--Body-->
    <div class="flex flex-row items-start w-auto h-auto order-2 self-stretch flex-grow-0 my-4">
      <recipe-ingredients />
      <recipe-instructions />
    </div>
  </div>
</template>

<script>

export default {

};
</script>
