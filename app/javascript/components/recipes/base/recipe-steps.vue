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
        v-for="(step, idx) in modifiedRecipeSteps"
        :key="idx"
        :index="idx"
      >
        <div
          class="flex justify-center items-start p-3 w-auto h-auto bg-gray-20 border border-gray-300 flex-none self-stretch flex-grow-0"
          v-if="!step.isEditing"
        >
          <div class="flex flex-col justify-center w-6 h-6 bg-yellow-500 shadow-sm rounded-full flex-none flex-grow-0 items-center mr-4 ">
            <div class="font-sans font-normal text-lg text-white my-auto">
              {{ idx + 1 }}
            </div>
          </div>
          <div class="flex w-auto h-auto font-sans font-normal text-base text-black bg-gray-20 flex-none flex-grow mr-4">
            {{ step.step.attributes.description }}
          </div>
          <div class="flex items-center w-6 h-6 mx-4">
            <dots-dropdown
              :elements="{
                del: true,
                edit: true
              }"
              @delete="deleteStep(idx)"
              @edit="editStep(idx)"
            />
          </div>
        </div>

        <div
          class="flex flex-col justify-center items-start p-3 w-auto h-auto bg-gray-20 border border-gray-300 flex-none self-stretch flex-grow-0"
          v-else
        >
          <text-box
            tid="newTextBox"
            class="flex-1 w-full"
            :value="step.step.attributes.description"
          />
          <div
            class="flex items-start w-auto h-11 flex-none self-stretch flex-grow-0"
          >
            <button
              class="flex justify-center items-center m-1 py-2.5 px-10 w-auto h-11 bg-green-500 shadow
              rounded-md font-sans font-normal text-base text-white flex-none flex-grow-0"
              @click="acceptEdit(idx)"
            >
              {{ $t('msg.recipes.saveChanges') }}
            </button>
            <button
              class="flex justify-center items-center m-1 py-2.5 px-10 w-auto h-11 border border-gray-800 box-border
                drop-shadow rounded-md font-sans font-normal text-base text-gray-800 flex-none flex-grow-0"
              @click="editStep(idx)"
            >
              {{ $t('msg.recipes.cancel') }}
            </button>
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
    recipeSteps: { type: Array, required: false, default() {
      return [];
    } },
  },
  data() {
    return {
      newStepDescription: null,
      error: '',
      modifiedRecipeSteps: [],
      recipeStepsSet: new Set(),
    };
  },
  watch: {
    recipeSteps() {
      for (let idx = 0; idx < this.recipeSteps.length; idx++) {
        if (!this.recipeStepsSet.has(this.recipeSteps[idx])) {
          this.modifiedRecipeSteps.push({
            step: this.recipeSteps[idx],
            isEditing: false,
          });
          this.recipeStepsSet.add(this.recipeSteps[idx]);
        }
      }
    },
  },
  methods: {
    addStep() {
      if (!this.newStepDescription) return;

      this.$emit('new-step', this.newStepDescription);
      this.newStepDescription = null;
    },
    deleteStep(idx) {
      this.modifiedRecipeSteps.splice(idx, 1);
      this.$emit('delete-step', idx);
    },
    editStep(idx) {
      this.modifiedRecipeSteps[idx].isEditing = !this.modifiedRecipeSteps[idx].isEditing;
    },
    acceptEdit(idx) {
      this.modifiedRecipeSteps[idx].step.attributes.description = document.getElementById('newTextBox').value;
      this.modifiedRecipeSteps[idx].isEditing = !this.modifiedRecipeSteps[idx].isEditing;
    },
  },
};
</script>
