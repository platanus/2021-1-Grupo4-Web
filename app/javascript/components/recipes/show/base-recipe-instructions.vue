<template>
  <div class="flex flex-col items-start pt-4 w-5/6 h-auto flex-grow-1 ml-6">
    <div class="w-13 h-6 font-sans font-normal text-lg text-black flex-grow-0 mt-2.5">
      {{ $t('msg.recipes.steps') }}
    </div>
    <div class="flex flex-col items-start w-auto h-auto self-stretch flex-grow-0 my-2.5">
      <instruction-step />
      <instruction-step />
      <instruction-step />
      <instruction-step />
    </div>
  </div>
</template>

<script>

export default {
};
</script>
