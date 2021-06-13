<template>
  <div>
    <div class="flex flex-col">
      <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
        <!--Title-->
        <div class="text-4xl order-0 flex-grow-0">
          {{ $t('msg.ingredients.title') }}
        </div>
      </div>
      <div class="flex flex-col p-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
        <!--SearchBar y Button-->
        <div class="flex items-center">
          <div class="relative text-yellow-700">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <img
                svg-inline
                src="../../../assets/images/magnifyng-glass-svg.svg"
                class="w-6 h-6 text-yellow-700"
              >
            </span>
            <input
              class="my-4 py-2 pl-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0 focus:outline-none"
              :placeholder="$t('msg.ingredients.search')"
              @keyup="filterIngredients"
              v-model="searchQuery"
            >
          </div>
          <base-button
            :elements="{ placeholder: $t('msg.ingredients.add'),
                         color: 'bg-green-500 hover:bg-green-700 text-white' }"
            @click="toggleAddModal"
          />
          <base-button
            :elements="{ placeholder: $t('msg.ingredients.searchInMarket'),
                         color: 'bg-green-500 hover:bg-green-700 text-white' }"
            @click="toggleSearchIngredientsModal"
          />
        </div>

        <!--Table-->
        <div class="flex items-center">
          <p
            v-if="this.ingredients.length===0"
          >
            {{ $t('msg.noElements') }} {{ $t('msg.ingredients.title') }}
          </p>
          <ingredients-table
            v-else
            :ingredients="filterIngredients"
            @edit="toggleEditModal"
            @del="toggleDelModal"
          />
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
      showingAdd: false,
      showingSearchIngredients: false,
      showingEdit: false,
      showingDel: false,
      ingredientToEdit: {},
      ingredientToDelete: {},
      ingredients: [],
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
    try {
      const response = await getIngredients();
      this.ingredients = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    }
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
    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
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

    async addIngredient() {
      let ingredientsInfo;
      this.showingAdd = !this.showingAdd;

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
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },

    async addMarketIngredient(productForm) {
      this.toggleSearchIngredientsModal();

      try {
        const {
          data:
            {
              data: { id, attributes },
            },
        } = await postIngredient(productForm);
        const ingredientToAdd = { id, ...attributes };
        this.ingredients.push(ingredientToAdd);
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },

    async editIngredient() {
      this.showingEdit = !this.showingEdit;
      try {
        const ingredientsInfo = this.$refs.editIngredientInfo.form;
        ingredientsInfo.ingredient_measures_attributes = ingredientsInfo /* eslint-disable-line camelcase */
          .ingredient_measures_attributes.filter(unit => unit.name && unit.quantity);
        this.addMeasuresToDelete(ingredientsInfo);
        await editIngredient(this.ingredientToEdit.id, ingredientsInfo);
        this.updateIngredient(ingredientsInfo);
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },
    addMeasuresToDelete(ingredientsInfo) {
      this.$refs.editIngredientInfo.measuresToDelete
        .forEach(elem => ingredientsInfo.ingredient_measures_attributes.push({ id: elem, _destroy: true }));
    },

    async deleteIngredient() {
      this.showingDel = !this.showingDel;
      try {
        await deleteIngredient(this.ingredientToDelete.id);
        this.ingredients = this.ingredients.filter(item => item.id !== this.ingredientToDelete.id);
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },

    async updateIngredient(ingredientEdited) {
      ingredientEdited.quantity = ingredientEdited.ingredient_measures_attributes[0].quantity;
      ingredientEdited.measure = ingredientEdited.ingredient_measures_attributes[0].name;
      ingredientEdited.id = this.ingredientToEdit.id;
      ingredientEdited.otherMeasures = { data: [] };
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
