<template>
  <div class="flex flex-col items-start pt-4 min-w-min h-auto flex-grow ml-6">
    <div class="w-13 h-6 font-sans font-normal text-lg text-black flex-grow-0 mt-2.5">
      {{ $t('msg.recipes.steps') }}
    </div>
    <div class="flex flex-col items-start w-auto h-auto self-stretch flex-grow-0 my-2.5">
      <instruction-step
        v-for="step in steps"
        :key="step.id"
        :step="step.attributes"
        :step-number="steps.indexOf(step)+1"
      />
    </div>
  </div>
</template>

<script>

export default {
  props: {
    steps: { type: Array, required: true },
  },
};
</script>
