<template>
  <div>
    <div
      class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8"
    >
      3. {{ $t('msg.recipes.steps') }}
    </div>
    <div
      class="mb-8"
      v-if="recipe.steps.data.length > 0"
    >
      <recipe-step
        v-for="step in recipe.steps.data"
        :key="step.id"
        :step="step.attributes"
      />
    </div>
    <div
      class="flex items-start h-6 bg-gray-50 font-sans font-light text-base text-black flex-none self-stretch flex-grow-0 mb-3"
      v-else
    >
      {{ $t('msg.recipes.noSteps') }}
    </div>
    <div class="flex items-center justify-between w-auto h-24 flex-none self-stretch flex-grow-0 mb-8">
      <input
        class="w-3/4 h-24 bg-white border border-gray-300 box-boder rounded flex-none flex-grow-1 px-3 py-0.5"
        :placeholder="$t('msg.recipes.step')"
        ref="step"
      >
      <button
        class="flex justify-center items-center py-1.5 px-10 border border-gray-800 drop-shadow
      rounded-md flex-none flex-grow-0 font-ans font-normal text-base text-gray-800"
        @click="addStep()"
      >
        {{ $t('msg.recipes.addstep') }}
      </button>
    </div>
  </div>
</template>

<script>
import recipeStep from './recipe-step.vue';

export default {
  data() {
    return {
      recipeSteps: [],
    };
  },
  props: {
    recipe: { type: Object, required: true },
  },
  components: {
    recipeStep,
  },
  methods: {
    addStep() {
      console.log(this.recipeSteps);
      const step = this.$refs.step.value;
      this.recipeSteps.push(step);
      console.log(step);
      console.log(this.recipeSteps);
    },
  },
  async created() {
    this.recipeSteps = this.recipe.steps.data;
  },
};
</script>
