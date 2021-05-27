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
          :elements="ingredients"
          :svg="{sixdots: false, cancel: true, menu_recipe: false, dropdown: false}"
          :input="true"
          :drag="false"
          @search="toggleAddIngredientModal"
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

    <base-modal
      @ok="addIngredientstoRecipe"
      @cancel="toggleAddIngredientModal"
      v-if="showingAddIngredientModal"
      :title="$t('msg.ingredients.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <div class="flex f-row w-full">
        <div class="mr-10">
          <search-ingredient-list
            :ingredients="getIngredients"
            @add-ingredient="addIngredient"
          />
        </div>
        <selected-ingredients
          :elements="selectedIngredients"
          :svg="{sixdots: true, cancel: false, menu_recipe: true}"
          :input="false"
          :placeholder="'-'"
          @delete-ingredient="deleteIngredient"
        />
      </div>
    </base-modal>
  </div>
</template>

<script>
import List from './list.vue';
import { postRecipe } from '../../../api/recipes.js';
import BaseModal from '../../base/base-modal.vue';
import SelectedIngredients from './selected-ingredients.vue';
import SearchIngredientList from './search-ingredient-list.vue';

export default {
  components: {
    List,
    BaseModal,
    SelectedIngredients,
    SearchIngredientList,
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
      showingAddIngredientModal: false,
      selectedIngredients: [],
      ingredients: [],
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
    toggleAddIngredientModal() {
      this.showingAddIngredientModal = !this.showingAddIngredientModal;
    },
    addIngredient(object) {
      let i;
      for (i = 0; i < this.selectedIngredients.length; i++) {
        if (this.selectedIngredients[i] === object) {
          return;
        }
      }
      this.selectedIngredients.push(object);
    },
    addIngredientstoRecipe() {
      this.selectedIngredients.forEach(ingredient => {
        this.ingredients.push(JSON.stringify(ingredient));
      });
      this.selectedIngredients = [];
      this.showingAddIngredientModal = !this.showingAddIngredientModal;
      this.$forceUpdate();
    },
    deleteIngredient(index) {
      this.selectedIngredients.splice(index, 1);
    },
  },
  computed: {
    getIngredients() {
      const newArray = [];
      for (let i = 0; i < this.objects.length; i++) {
        newArray.push(this.objects[i]);
      }
      return newArray;
    },
  },
};
</script>
