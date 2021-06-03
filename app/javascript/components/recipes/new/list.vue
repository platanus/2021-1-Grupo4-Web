<template>
  <div>
    <h2 class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
      {{ placeholder }}
    </h2>
    <div v-if="!drag">
      <div
        v-for="(element, index) in ingredients"
        :key="index"
      >
        <container
          :element="element"
          :svg="svg"
          :input="input"
          :color="color('elements', element)"
          @del-ingredient="delIngredient(element)"
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
    elements: { type: Array, default: () => ([]) },
    svg: { type: Object, required: true },
    placeholder: { type: String, required: true },
    input: { type: Boolean, required: true },
    drag: { type: Boolean, required: true },
  },
  data() {
    return {
      steps: [],
      ingredients: this.elements,
      forceupdate: false,
    };
  },
  methods: {
    search() {
      this.$emit('search');
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
      if (text.value === '') {
        alert(this.$t('msg.recipes.alertEmptyStep')); // eslint-disable-line no-alert
      } else if (this.steps.includes(text.value) === false) {
        this.steps.push(text.value);
        this.$emit('update', text.value);
        text.value = '';
        this.forceUpdate = true;
        this.$forceUpdate();
      } else {
        alert(this.$t('msg.recipes.alertExistingStep')); // eslint-disable-line no-alert
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
    delIngredient(ingredient) {
      const index = this.ingredients.indexOf(ingredient);
      this.ingredients.splice(index, 1);
      this.$forceUpdate();
    },
  },
};
</script>
