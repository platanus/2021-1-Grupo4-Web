<template>
  <div>
    <h2 class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
      {{ placeholder }}
    </h2>
    <div v-if="!drag">
      <div
        v-for="element in elements"
        :key="element"
      >
        <container
          :text="element"
          :svg="svg"
          :input="input"
          :color="color('elements', element)"
        />
      </div>
    </div>

    <div v-if="input">
      <container
        :text="$t('msg.recipes.cost')"
        :svg="{}"
        :input="false"
        :color="false"
        class="my-4"
      />

      <base-button
        :elements="{
          placeholder: $t('msg.recipes.more'),
          color: 'bg-white text-black border-2 border-blue-600 align-center hover:bg-gray-300 h-12'
        }"
        @click="search"
        class="w-full"
      />
    </div>

    <div
      v-if="drag"
    >
      <!--drag-and-drop
        :elements="this.steps"
        :svg="svg"
        :forceupdate="this.forceupdate"
      /-->
      <div
        v-for="step in this.steps"
        :key="step"
      >
        <container
          :text="step"
          :svg="svg"
          :input="input"
          :color="color('steps', step)"
          @del="deleteStep"
          @edit="editStep"
        />
      </div>

      <text-box
        :placeholder="$t('msg.recipes.step')"
      />

      <div class="grid grid-cols-4">
        <div />
        <div />
        <div />
        <base-button
          :elements="{
            placeholder: $t('msg.recipes.addstep'),
            color: 'bg-white text-black border-2 border-blue-600 align-center hover:bg-gray-300 h-12'
          }"
          @click="addStep"
          class="w-full"
        />
      </div>
    </div>
  </div>
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Array, required: true },
    svg: { type: Object, required: true },
    placeholder: { type: String, required: true },
    input: { type: Boolean, required: true },
    drag: { type: Boolean, required: true },
  },
  data() {
    return {
      steps: [],
      forceupdate: false,
    };
  },
  methods: {
    search() {
      return null;
    },
    color(list, element) {
      if (list === 'elements') {
        // eslint-disable-next-line no-magic-numbers
        const index = this.elements.indexOf(element) % 2;
        if (index === 0) {
          return true;
        }
      } else {
        // eslint-disable-next-line no-magic-numbers
        const index = this.steps.indexOf(element) % 2;
        if (index === 0) {
          return true;
        }
      }

      return false;
    },
    addStep() {
      const text = document.getElementById('textarea');
      this.steps.push(text.value);
      text.value = '';
      this.forceUpdate = true;
      this.$forceUpdate();
    },
    deleteStep(originalText) {
      const index = this.steps.indexOf(originalText);
      this.steps.splice(index, 1);
      this.$forceUpdate();
    },
    editStep(originalText, newText) {
      const index = this.steps.indexOf(originalText);
      this.steps[index] = newText;
      this.$forceUpdate();
    },
  },
};
</script>
