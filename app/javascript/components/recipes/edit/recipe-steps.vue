<template>
  <div>
    <div
      class="h-7 w-auto font-hind font-bold text-lg text-black flex-none self-stretch flex-grow-0 mb-8"
    >
      3. {{ $t('msg.recipes.steps') }}
    </div>
    <div
      class="mb-8"
      v-if="recipeSteps.length > 0"
    >
      <div
        v-for="(step, idx) in recipeSteps"
        :key="idx"
        :index="idx"
      >
        <div class="flex justify-center items-start p-3 w-auto h-auto bg-gray-20 border border-gray-300 flex-none self-stretch flex-grow-0">
          <div class="flex flex-col justify-center w-6 h-6 bg-yellow-500 shadow-sm rounded-full flex-none flex-grow-0 items-center mr-4 ">
            <div class="font-sans font-normal text-lg text-white my-auto">
              {{ idx + 1 }}
            </div>
          </div>
          <div class="flex w-auto h-auto font-sans font-normal text-base text-black bg-gray-20 flex-none flex-grow mr-4">
            {{ step.attributes.description }}
          </div>
          <div class="flex items-center w-6 h-6 mx-4">
            <dots-dropdown
              :elements="{
                del: true
              }"
              @delete="deleteStep(idx)"
            />
          </div>
        </div>
      </div>
    </div>
    <div
      class="flex items-start h-6 bg-gray-50 font-sans font-light text-base text-black mb-3"
      v-else
    >
      {{ $t('msg.recipes.noSteps') }}
    </div>
    <div class="flex items-center justify-between w-auto h-24 mb-8">
      <input
        class="w-3/4 h-24 bg-white border border-gray-300 box-boder rounded flex-none flex-grow-1 px-3 py-0.5"
        :placeholder="$t('msg.recipes.step')"
        v-model="newStepDescription"
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
export default {
  props: {
    recipeSteps: { type: Array, required: true },
  },
  data() {
    return {
      newStepDescription: null,
      error: '',
    };
  },
  methods: {
    addStep() {
      if (!this.newStepDescription) return;

      this.$emit('new-step', this.newStepDescription);
      this.newStepDescription = null;
    },
    deleteStep(idx) {
      this.$emit('delete-step', idx);
    },
  },
};
</script>
