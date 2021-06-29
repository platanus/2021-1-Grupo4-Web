<template>
  <div>
    <div class="flex flex-col">
      <div class="flex items-center h-8 mt-1">
        <!--Title-->
        <div class="text-4xl">
          {{ $t('msg.ingredients.title') }}
        </div>
        <span
          class="flex my-auto w-8 h-8 pl-2 ml-2"
          v-if="loading"
        >
          <base-spinner />
        </span>
      </div>
      <div class="flex flex-col p-10 w-full bg-gray-50 my-10">
        <!--SearchBar y Button-->
        <div class="flex flex-col lg:flex-row pb-4">
          <div class="flex items-center p-2 lg:w-1/3">
            <div class="relative text-yellow-700 w-full">
              <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                <img
                  svg-inline
                  src="../../../assets/images/magnifyng-glass-svg.svg"
                  class="w-6 h-6 text-yellow-700"
                >
              </span>
              <input
                class="w-full py-2 pl-12 bg-gray-50 border-2 border-gray-600 rounded self-stretch focus:outline-none z-200"
                :placeholder="$t('msg.ingredients.search')"
                @keyup="filterIngredients"
                v-model="searchQuery"
              >
            </div>
          </div>
          <div class="flex justify-start px-2 pb-2 my-auto">
            <base-button
              :elements="{ placeholder: $t('msg.ingredients.add'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
              @click="toggleAddModal"
            />
          </div>
          <div class="flex justify-start px-2 pb-2 my-auto">
            <base-button
              :elements="{ placeholder: $t('msg.ingredients.searchInMarket'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
              @click="toggleSearchIngredientsModal"
            />
          </div>
        </div>

        <!--Table-->
        <div v-if="!loading">
          <p
            v-if="this.ingredients.length===0"
            class="p-2"
          >
            {{ $t('msg.noElements') }} {{ $t('msg.ingredients.title').toLowerCase() }}
          </p>
          <div
            v-else
            class="flex w-full 2xl:justify-center items-center overflow-auto"
          >
            <ingredients-table
              :ingredients="filterIngredients"
              @edit="toggleEditModal"
              @del="toggleDelModal"
              @updateInventory="UpdateInventory"
            />
          </div>
        </div>
      </div>

      <!--AddModal-->
      <base-modal
        @ok="addIngredient"
        @cancel="toggleAddModal"
        v-if="showingAdd"
        :title="$t('msg.ingredients.add')"
        :ok-button-label="$t('msg.add')"
        :cancel-button-label="$t('msg.cancel')"
      >
        <ingredients-form
          ref="addIngredientInfo"
          :units="['Kg','Litro', 'Cucharadas', 'Unidades', 'Oz']"
          :edit-mode="false"
          :market-ingredient="marketIngredient"
        />
      </base-modal>

      <!--SearchIngredientsModal-->
      <base-modal
        @cancel="toggleSearchIngredientsModal"
        v-if="showingSearchIngredients"
        :title="$t('msg.ingredients.searchInMarket')"
        :ok-button-present="false"
        :cancel-button-label="$t('msg.cancel')"
      >
        <search-market-ingredients
          @submit="addMarketIngredient"
        />
      </base-modal>

      <!--EditModal-->
      <base-modal
        @ok="editIngredient"
        @cancel="toggleEditModal"
        v-if="showingEdit"
        :title="$t('msg.ingredients.edit')"
        :ok-button-label="$t('msg.save')"
        :cancel-button-label="$t('msg.cancel')"
      >
        <ingredients-form
          ref="editIngredientInfo"
          :units="['Kg','Litro', 'Cucharadas', 'Unidades', 'Oz']"
          :edit-mode="true"
          :ingredient="this.ingredientToEdit"
        />
      </base-modal>

      <!--DeleteModal-->
      <base-modal
        @ok="deleteIngredient"
        @cancel="toggleDelModal"
        v-if="showingDel"
        :title="$t('msg.ingredients.delete')"
        :ok-button-label="$t('msg.yesDelete')"
        :cancel-button-label="$t('msg.cancel')"
      >
        <p>{{ $t('msg.ingredients.deleteMsg') }}</p>
      </base-modal>
    </div>
  </div>
</template>

<script>

import Vue from 'vue';
import { getIngredients, postIngredient, deleteIngredient, editIngredient } from './../../api/ingredients.js';
import IngredientsForm from './ingredients-form';
import IngredientsTable from './ingredients-table';
import SearchMarketIngredients from './search-market-ingredients';

export default {

  data() {
    return {
      loading: false,
      showingAdd: false,
      showingSearchIngredients: false,
      showingEdit: false,
      showingDel: false,
      ingredientToEdit: {},
      ingredientToDelete: {},
      ingredients: [],
      marketIngredient: undefined,
      searchQuery: '',
      error: '',
    };
  },

  components: {
    IngredientsForm,
    SearchMarketIngredients,
    IngredientsTable,
  },

  async created() {
    this.loading = true;
    try {
      const response = await getIngredients();
      this.ingredients = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
    } catch (error) {
      this.error = error;
    } finally {
      this.loading = false;
    }
    this.roundInventory();
  },

  computed: {
    filterIngredients() {
      if (this.searchQuery) {
        return this.ingredients.filter(item => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.ingredients;
    },
  },

  methods: {
    roundInventory() {
      this.ingredients.forEach(ingredient => {
        // eslint-disable-next-line no-magic-numbers
        ingredient.inventory = Math.round(ingredient.inventory * 100) / 100;
      });
    },
    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
      this.marketIngredient = undefined;
    },

    toggleSearchIngredientsModal() {
      this.showingSearchIngredients = !this.showingSearchIngredients;
    },

    toggleEditModal(ingredient) {
      this.showingEdit = !this.showingEdit;
      this.ingredientToEdit = ingredient;
    },

    toggleDelModal(ingredient) {
      this.showingDel = !this.showingDel;
      this.ingredientToDelete = ingredient;
    },

    // eslint-disable-next-line max-statements
    async addIngredient() {
      let ingredientsInfo;
      this.showingAdd = !this.showingAdd;
      this.loading = true;
      try {
        ingredientsInfo = this.$refs.addIngredientInfo.form;
        ingredientsInfo.ingredient_measures_attributes = ingredientsInfo /* eslint-disable-line camelcase */
          .ingredient_measures_attributes.filter(unit => unit.name && unit.quantity);
        const {
          data:
            { data: { id, attributes },
            },
        } = await postIngredient(ingredientsInfo);
        const ingredientToAdd = { id, ...attributes };
        this.ingredients.push(ingredientToAdd);
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },

    async addMarketIngredient(productForm) {
      this.toggleSearchIngredientsModal();
      this.toggleAddModal();
      this.marketIngredient = productForm;
    },
    addInventoryToIngredient(ingredientsInfo, id) {
      this.ingredients.forEach(elem => {
        if (elem.id === id) {
          ingredientsInfo.inventory = elem.inventory;
        }
      });

      return ingredientsInfo;
    },

    // eslint-disable-next-line max-statements
    async editIngredient() {
      this.showingEdit = !this.showingEdit;
      this.loading = true;
      try {
        const ingredientsInfo = this.$refs.editIngredientInfo.form;
        ingredientsInfo.ingredient_measures_attributes = ingredientsInfo /* eslint-disable-line camelcase */
          .ingredient_measures_attributes.filter(unit => unit.name && unit.quantity);
        this.addMeasuresToDelete(ingredientsInfo);
        const ingredientsInfoFinal = this.addInventoryToIngredient(ingredientsInfo, this.ingredientToEdit.id);
        await editIngredient(this.ingredientToEdit.id, ingredientsInfoFinal);
        this.updateIngredient(ingredientsInfoFinal);
        this.error = '';
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
    addMeasuresToDelete(ingredientsInfo) {
      this.$refs.editIngredientInfo.measuresToDelete
        .forEach(elem => ingredientsInfo.ingredient_measures_attributes.push({ id: elem, _destroy: true }));
    },

    async deleteIngredient() {
      this.showingDel = !this.showingDel;
      this.loading = true;
      try {
        await deleteIngredient(this.ingredientToDelete.id);
        this.ingredients = this.ingredients.filter(item => item.id !== this.ingredientToDelete.id);
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
    async UpdateInventory(ingredient) {
      try {
        await editIngredient(ingredient.id, { 'inventory': ingredient.inventory });
      } catch (error) {
        this.error = error;
      }
    },

    async updateIngredient(ingredientEdited) {
      ingredientEdited.quantity = ingredientEdited.ingredient_measures_attributes[0].quantity;
      ingredientEdited.measure = ingredientEdited.ingredient_measures_attributes[0].name;
      ingredientEdited.id = this.ingredientToEdit.id;
      ingredientEdited.otherMeasures = { data: [] };
      ingredientEdited.providerName = ingredientEdited.provider_name;
      ingredientEdited.ingredient_measures_attributes.forEach(element => {
        ingredientEdited.otherMeasures.data
          .push({ id: element.id, attributes: { name: element.name, quantity: element.quantity } });
      });
      const objectIndex = this.ingredients.findIndex((obj => obj.id === this.ingredientToEdit.id));
      Vue.set(this.ingredients, objectIndex, ingredientEdited);
    },
  },
};
</script>
