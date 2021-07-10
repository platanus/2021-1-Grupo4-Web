<template>
  <div>
    <!-- Title and Back Button -->
    <div class="flex items-center">
      <a href="/recipes">
        <img
          class="h-6 w-6 text-white mr-2"
          svg-inline
          src="../../../../assets/images/arrow-left-svg.svg"
        >
      </a>
      <div class="text-4xl font-bold">
        {{ this.recipe.name }}
      </div>
      <span
        class="flex m-auto w-8 h-8 ml-2"
        v-if="loading"
      >
        <base-spinner />
      </span>
    </div>

    <div
      v-if="!loading"
      class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10"
    >
      <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-1">
        <!--Info-->
        <recipe-info
          :portions="recipe.portions"
          :cook-minutes="recipe.cookMinutes"
          :recipe-price="recipePrice"
        />
        <!-- Buttons -->
        <div class="flex items-center">
          <button
            class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-red-600 rounded flex-grow-0 mx-2 text-red-600 focus:outline-none"
            @click="toggleDelModal"
          >
            {{ $t('msg.recipes.delete') }}
          </button>
          <a
            :href="`/recipes/${recipeId}/edit`"
            class="flex justify-center items-center px-3 w-24 h-8 bg-white border-2 border-gray-800 rounded flex-grow-0 mx-2 text-gray-800 focus:outline-none"
          >
            {{ $t('msg.recipes.edit') }}
          </a>
        </div>
      </div>

      <!-- Body-->
      <div class="flex items-start justify-between w-auto h-auto self-stretch flex-grow-0 my-4">
        <recipe-ingredients :recipe-ingredients="this.recipe.recipeIngredients.data" />
      </div>
      <div class="flex items-start justify-between w-auto h-auto self-stretch flex-grow-0 my-4">
        <recipe-instructions :steps="this.recipe.steps.data" />
      </div>
    </div>

    <!--DeleteModal-->
    <base-modal
      @ok="deleteRecipe"
      @cancel="toggleDelModal"
      v-if="showingDel"
      :title="$t('msg.recipes.delete')"
      :ok-button-label="$t('msg.yesDelete')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <!-- Critical associations -->
      <span
        class="flex m-auto w-8 h-8"
        v-if="loadingAssociations"
      >
        <base-spinner />
      </span>
      <div v-else>
        <div v-if="criticalAssociations.length > 0">
          <p>{{ $t('msg.recipes.associationWarning') }}</p>
          <base-one-column-table
            :header="$t('msg.menus.title')"
            :rows="criticalAssociations"
          />
        </div>
        <!-- Delete msg -->
        <p class="mt-4">
          {{ $t('msg.recipes.deleteMsg') }}
        </p>
      </div>
    </base-modal>
  </div>
</template>

<script>

import { getRecipe, deleteRecipe, getCriticalAssociations } from '../../../api/recipes.js';
import RecipeIngredients from './recipe-ingredients';
import RecipeInstructions from './recipe-instructions';
import RecipeInfo from './recipe-info';
import { getPriceOfSelectedIngredient } from '../../../utils/recipeUtils.js';

export default {
  components: {
    RecipeIngredients,
    RecipeInstructions,
    RecipeInfo,
  },

  props: {
    recipeId: { type: Number, required: true },
  },

  data() {
    return {
      loading: false,
      loadingAssociations: false,
      showingDel: false,
      status: '',
      error: '',
      criticalAssociations: [],
      recipe: {
        name: '',
        portions: 0,
        cookMinutes: 0,
        recipeIngredients: { data: [] },
        steps: { data: [] },
      },
    };
  },

  async created() {
    this.loading = true;
    try {
      const response = await getRecipe(this.recipeId);
      this.recipe = { id: response.data.data.id, ...response.data.data.attributes };
      this.status = status;
    } catch (error) {
      this.error = error;
    } finally {
      this.loading = false;
    }
  },

  methods: {
    toggleDelModal() {
      this.showingDel = !this.showingDel;
      if (this.showingDel) {
        this.getIngredientAssociations(this.recipe.id);
      }
    },
    async getIngredientAssociations(recipeId) {
      this.loadingAssociations = true;
      try {
        const response = await getCriticalAssociations(recipeId);
        this.criticalAssociations = response.data.menus.map((element) => element.name);
      } catch (error) {
        this.error = error;
      } finally {
        this.loadingAssociations = false;
      }
    },
    ingredientFinalPrice(quantity, price) {
      return (quantity * price);
    },
    async deleteRecipe() {
      this.loading = true;
      try {
        await deleteRecipe(this.recipe.id);
        window.location.href = '/recipes';
        this.error = '';
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
  },

  computed: {
    recipePrice() {
      return this.recipe.recipeIngredients.data.reduce((recipePrice, recipeIngredient) =>
        recipePrice + getPriceOfSelectedIngredient(recipeIngredient.attributes), 0);
    },
  },
};
</script>
