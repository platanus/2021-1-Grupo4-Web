<template>
  <div class="flex flex-col items-start pt-4 w-56 h-auto flex-grow-0 ml-2">
    <div class="w-28 h-6 font-sans font-normal not-italic text-lg text-black flex-grow-0 my-2.5">
      {{ $t('msg.ingredients.title') }}
    </div>
    <div class="flex flex-col items-start p-4 w-56 bg-gray-200 rounded flex-grow-0 my-2.5">
      <recipe-ingredient />
      <recipe-ingredient />
      <recipe-ingredient />
      <recipe-ingredient />
      <recipe-ingredient />
      <recipe-ingredient />
      <recipe-ingredient />
    </div>
  </div>
</template>

<script>

export default {

};
</script>
