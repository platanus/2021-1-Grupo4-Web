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
      <draggable
        v-model="modifiedRecipeSteps"
        @end="onEnd"
      >
        <transition-group
          type="transition"
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
              <div
                class="flex w-auto h-auto font-sans font-normal text-base text-black bg-gray-20 flex-none flex-grow mr-4"
                v-if="step.step.attributes.description === null"
              >
                {{ $t('msg.recipes.noSteps') }}
              </div>
              <textarea
                rows="1"
                class="flex font-sans font-normal text-base text-black bg-gray-20 flex-none flex-grow mr-4 w-8/12 overflow-x-scroll bg-gray-50"
                v-model="step.step.attributes.description"
                v-else
              />
              <div class="flex m-auto items-center w-6 h-6 mx-4">
                <dots-dropdown
                  :elements="{
                    del: true,
                    edit: true,
                    last: lastStep(idx)
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
              <textarea
                class="flex-1 w-full resize-y border-2 rounded-md border-gray-300 w-full my-4 p-4"
                v-model="modifiedRecipeSteps[idx].editingStepDescription"
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
                  @click="closeEditStep(idx)"
                >
                  {{ $t('msg.recipes.cancel') }}
                </button>
              </div>
            </div>
          </div>
        </transition-group>
      </draggable>
    </div>
    <div
      class="flex items-start h-6 bg-gray-50 font-sans font-light text-base text-black mb-3"
      v-if="recipeSteps.length === 0"
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
import draggable from 'vuedraggable';

export default {
  components: {
    draggable,
  },
  props: {
    recipeSteps: { type: Array, required: false, default() {
      return [];
    } },
  },
  data() {
    return {
      newStepDescription: null,
      error: '',
      modifiedRecipeSteps: this.recipeSteps.map((step) => ({ step, isEditing: false, editingStepDescription: '' })),
      recipeStepsSet: new Set([...this.recipeSteps]),
      oldIndex: '',
      newIndex: '',
    };
  },
  watch: {
    recipeSteps() {
      for (let idx = 0; idx < this.recipeSteps.length; idx++) {
        if (!this.recipeStepsSet.has(this.recipeSteps[idx])) {
          this.modifiedRecipeSteps.push({
            step: this.recipeSteps[idx],
            isEditing: false,
            editingStepDescription: '',
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
    onEnd(event) {
      this.oldIndex = event.oldIndex;
      this.newIndex = event.newIndex;
      this.$emit('switch-steps', this.oldIndex, this.newIndex);
    },
    editStep(idx) {
      this.modifiedRecipeSteps[idx].editingStepDescription = this.modifiedRecipeSteps[idx].step.attributes.description;
      this.modifiedRecipeSteps[idx].isEditing = !this.modifiedRecipeSteps[idx].isEditing;
    },
    acceptEdit(idx) {
      this.modifiedRecipeSteps[idx].step.attributes.description = this.modifiedRecipeSteps[idx].editingStepDescription;
      this.modifiedRecipeSteps[idx].isEditing = !this.modifiedRecipeSteps[idx].isEditing;
    },
    closeEditStep(idx) {
      this.modifiedRecipeSteps[idx].isEditing = !this.modifiedRecipeSteps[idx].isEditing;
    },
    lastStep(idx) {
      return (idx === this.recipeSteps.length - 1);
    },
  },
};
</script>
