<template>
  <div class="flex flex-row divide-x-2 divide-gray-400 border-2 border-solid border-gray-400 box-border my-2">
    <div class="flex flex-row w-10/12 justify-between items-center p-6 static h-24 bg-white flex-none flex-grow-0 self-stretch">
      <recipes-item-info
        :recipe-name="recipe.name"
        :recipe-portions="recipe.portions"
        :recipe-minutes="recipe.cookMinutes"
      />
      <recipes-item-price
        :id-recipe="recipe.id"
        :recipe-price="recipePrice"
      />
    </div>
    <div class="flex w-full">
      <div class="flex flex-col justify-center items-center w-full">
        <a
          class=" flex justify-center items-center cursor-pointer h-12 underline text-xl focus:outline-none"
          :href="`/recipes/${recipe.id}/edit`"
        >
          <span>
            <img
              svg-inline
              src="../../../../../assets/images/pencil-svg.svg"
              class="text-black h-6 w-6"
            >
          </span>
          {{ $t('msg.recipes.edit') }}
        </a>
        <button
          class="flex justify-center cursor-pointer h-12 underline text-xl text-red-600 focus:outline-none"
          @click="toggleDelModal"
        >
          <span>
            <img
              svg-inline
              src="../../../../../assets/images/red-trashcan-svg.svg"
              class="stroke-current text-red-600 h-6 w-6"
            >
          </span>
          {{ $t('msg.recipes.delete') }}
        </button>
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
        class="flex my-auto w-8 h-8 pl-2"
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
import { deleteRecipe, getCriticalAssociations } from '../../../../api/recipes.js';
import RecipesItemInfo from './recipes-item-info';
import RecipesItemPrice from './recipes-item-price';
import { getPriceOfSelectedIngredient } from '../../../../utils/recipeUtils.js';

export default {

  components: {
    RecipesItemInfo,
    RecipesItemPrice,
  },

  props: {
    recipe: { type: Object, required: true },
  },
  data() {
    return {
      showingDel: false,
      loading: false,
      loadingAssociations: false,
    };
  },
  methods: {
    ingredientFinalPrice(quantity, price) {
      return (quantity * price);
    },
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
