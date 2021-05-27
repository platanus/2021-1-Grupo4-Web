<template>
  <div>
    <!-- Title -->
    <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-3">
      <div class="flex items-center">
        <a href="/recipes">
          <img
            class="h-6 w-6 text-white mx-2"
            svg-inline
            src="../../../../assets/images/arrow-left-svg.svg"
          >
        </a>
        <div class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
          {{ $t('msg.recipes.create') }}
        </div>
      </div>
    </div>

    <p class="text-xl">
      {{ $t('msg.recipes.basic') }}
    </p>

    <div class="grid grid-cols-4 gap-4">
      <input
        id="name"
        :placeholder="$t('msg.recipes.name')"
        :search-icon="false"
        v-model="recipe.name"
        class="col-span-2 w-full mx-1 my-4 p-2 border-2 rounded border-gray-300"
      >
      <input
        id="portions"
        :placeholder="$t('msg.recipes.portions')"
        :search-icon="false"
        v-model="recipe.portions"
        class="w-full mx-1 my-4 p-2 border-2 rounded border-gray-300"
      >
      <input
        id="preparation"
        :placeholder="$t('msg.recipes.preparation')"
        :search-icon="false"
        v-model="recipe.cook_minutes"
        class="w-full mx-1 my-4 p-2 border-2 rounded border-gray-200 border-gray-300"
      >
    </div>

    <div class="grid grid-cols-3 gap-4">
      <div>
        <list
          :placeholder="$t('msg.recipes.ingredients')"
          :elements="getIngredients"
          :svg="{sixdots: false, cancel: true, menu_recipe: false, dropdown: false}"
          :input="true"
          :drag="false"
        />
      </div>
      <div
        id="steps"
        class="col-span-2"
      >
        <list
          :placeholder="$t('msg.recipes.steps')"
          :svg="{sixdots: true, cancel: false, menu_recipe: true, dropdown: true}"
          :input="false"
          :drag="true"
          @update="addStep"
        />
      </div>
    </div>
    <div class="grid grid-cols-6">
      <base-button
        :elements="{
          placeholder: $t('msg.recipes.create'),
          color: 'bg-blue-600 text-white hover:bg-blue-400 mb-4'
        }"
        class="col-start-6"
        @click="create"
      />
    </div>
  </div>
</template>

<script>
import List from './list.vue';
import { postRecipe } from '../../../api/recipes.js';

export default {
  components: {
    List,
  },
  props: {
    objects: { type: Array, required: true },
  },
  data() {
    return {
      recipe: {
        name: '',
        portions: '',
        cook_minutes: '', // eslint-disable-line camelcase
        steps_attributes: [], // eslint-disable-line camelcase
      },
      steps: [],
      error: '',
    };
  },
  methods: {
    async create() {
      if (this.recipe.name === '' || this.recipe.portions === '' || this.recipe.preparation === '') {
        alert(this.$t('msg.recipes.alertEmptyStep')); // eslint-disable-line no-alert

        return false;
      }
      try {
        await postRecipe(this.recipe);
        window.location = '/recipes';
      } catch (error) {
        this.error = error;
      }

      return null;
    },
    addStep(step) {
      this.recipe.steps_attributes.push({
        description: step,
        media_url: 'https://media_url', // eslint-disable-line camelcase
      });
    },
  },
  computed: {
    getIngredients() {
      const newArray = [];
      for (let i = 0; i < this.objects.length - 1; i++) {
        newArray.push(this.objects[i]);
      }

      return newArray;
    },
  },
};
</script>
