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
          :element="element"
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
        <base-button
          :elements="{
            placeholder: $t('msg.recipes.addstep'),
            color: 'bg-white text-black border-2 border-blue-600 align-center hover:bg-gray-300 h-12 -mx-2'
          }"
          @click="addStep"
          class="w-full col-start-4"
        />
      </div>
    </div>
  </div>
</template>

<script>
import Container from './container.vue';

export default {
  components: {
    Container,
  },
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
      const two = 2;
      if (list === 'elements') {
        const index = this.elements.indexOf(element) % two;
        if (index === 0) {
          return true;
        }
      } else {
        const index = this.steps.indexOf(element) % two;
        if (index === 0) {
          return true;
        }
      }

      return false;
    },
    addStep() {
      const text = document.getElementById('textarea');
      if (this.steps.includes(text.value) === false) {
        this.steps.push(text.value);
        text.value = '';
        this.forceUpdate = true;
        this.$forceUpdate();
      } else {
        alert(this.$t('msg.recipes.alert')); // eslint-disable-line no-alert
      }
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
