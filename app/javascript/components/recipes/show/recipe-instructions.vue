<template>
  <div class="flex flex-col items-start pt-4 min-w-min h-auto flex-grow ml-2">
    <div class="w-13 h-6 font-sans font-normal text-lg text-black font-bold flex-grow-0 mt-2.5 mb-6">
      {{ $t('msg.recipes.steps') }}
    </div>
    <p
      v-if="steps.length === 0"
    >
      {{ $t('msg.recipes.noSteps') }}
    </p>
    <div
      v-else
      class="flex flex-col items-start w-auto h-auto self-stretch flex-grow-0 my-2.5"
    >
      <recipe-instructions-step
        v-for="step in steps"
        :key="step.id"
        :step="step.attributes"
        :step-number="steps.indexOf(step)+1"
      />
    </div>
  </div>
</template>

<script>
import RecipeInstructionsStep from './recipe-instructions-step';

export default {
  components: {
    RecipeInstructionsStep,
  },
  props: {
    steps: { type: Array, required: true },
  },
};
</script>
