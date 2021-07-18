<template>
  <div class="flex flex-col">
    <div class="flex items-center">
      <!--Title-->
      <div class="text-4xl font-bold">
        {{ $t('msg.ingredients.title') }}
      </div>
    </div>

    <!-- Alert unexpected error -->
    <base-alert
      :variable="unexpectedError"
      :alert-name="'unexpectedError'"
      :success="false"
      @closeAlert="closeAlert"
    />

    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 my-10">
      <!--SearchBar y Button-->
      <div
        class="flex flex-col lg:flex-row pb-4"
      >
        <div class="flex items-center py-2 pr-2 lg:w-1/2">
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
              v-model="searchQuery"
            >
          </div>
        </div>
        <div class="flex flex-wrap justify-end w-full">
          <div class="p-2 my-auto">
            <base-button
              :elements="{ placeholder: $t('msg.ingredients.inventory.editInventories'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
              @click="goToEditInventories"
            />
          </div>
          <div class="p-2 my-auto">
            <base-button
              :elements="{ placeholder: $t('msg.ingredients.add'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
              @click="toggleAddModal"
            />
          </div>
          <div class="p-2 pr-0 my-auto">
            <base-button
              :elements="{ placeholder: $t('msg.ingredients.searchInMarket'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
              @click="toggleSearchIngredientsModal"
            />
          </div>
        </div>
      </div>

      <!--Table-->
      <div
        class="w-auto m-auto"
        v-if="loading"
      >
        <span
          class="flex w-12 h-12 ml-2"
        >
          <base-spinner />
        </span>
      </div>
      <div v-if="!loading">
        <p
          v-if="this.ingredients.length===0"
          class="p-2"
        >
          {{ $t('msg.noElements') }} {{ $t('msg.ingredients.title').toLowerCase() }}
        </p>
        <div
          v-else
          class="flex 2xl:justify-center items-center"
        >
          <ingredients-table
            :ingredients="filteredIngredients"
            :page-size="8"
            :filter="searchQuery"
            @edit="toggleEditModal"
            @del="toggleDelModal"
            @updateInventory="UpdateInventory"
            @updateMinimumQuantity="updateMinimumQuantity"
          />
        </div>
      </div>
    </div>

    <!--AddModal-->
    <base-modal
      @ok="addIngredient"
      @cancel="toggleAddModal"
      @back="goBackAddModal"
      v-if="showingAdd"
      :title="$t('msg.ingredients.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
      :back="true"
    >
      <ingredients-form
        ref="addIngredientInfo"
        :edit-mode="false"
        :market-ingredient="marketIngredient"
        :ingredient-errors="errors"
      />
    </base-modal>

    <!--SearchIngredientsModal-->
    <base-modal
      @cancel="toggleSearchIngredientsModal"
      v-if="showingSearchIngredients"
      :title="$t('msg.ingredients.searchInMarket')"
      :ok-button-present="false"
      :cancel-button-label="$t('msg.cancel')"
      :class="invisible ? 'hidden' : ''"
    >
      <search-market-ingredients
        @make-invisible="makeInvisible"
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
        :edit-mode="true"
        :ingredient="this.ingredientToEdit"
        :ingredient-errors="errors"
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
      <!-- Critical associations -->
      <span
        class="flex m-auto w-8 h-8"
        v-if="loadingAssociations"
      >
        <base-spinner />
      </span>
      <div v-else>
        <div v-if="criticalAssociations.length > 0">
          <p>{{ $t('msg.ingredients.associationWarning') }}</p>
          <base-one-column-table
            :header="$t('msg.recipes.title')"
            :rows="criticalAssociations"
          />
        </div>
        <!-- Delete msg -->
        <p class="mt-4">
          {{ $t('msg.ingredients.deleteMsg') }}
        </p>
      </div>
    </base-modal>
  </div>
</template>

<script>

import Vue from 'vue';
import { getIngredients, postIngredient, deleteIngredient,
  editIngredient, getCriticalAssociations } from './../../api/ingredients.js';
import { floatNonZero, intGeqZero, geqZero, requiredField } from '../../utils/validations.js';
import IngredientsForm from './ingredients-form';
import IngredientsTable from './ingredients-table';
import SearchMarketIngredients from './search-market-ingredients';

export default {

  data() {
    return {
      invisible: false,
      loading: false,
      loadingAssociations: false,
      showingAdd: false,
      showingSearchIngredients: false,
      showingEdit: false,
      showingDel: false,
      ingredientToEdit: {},
      ingredientToDelete: {},
      ingredients: [],
      marketIngredient: undefined,
      searchQuery: '',
      criticalAssociations: [],
      unexpectedError: false,
      errors: {
        name: '',
        quantity: '',
        measure: '',
        price: '',
        minimumQuantity: '',
      },
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
      this.unexpectedError = true;
    } finally {
      this.loading = false;
    }
    this.roundInventory();
  },

  computed: {
    filteredIngredients() {
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
    closeAlert() {
      this.unexpectedError = false;
    },
    roundInventory() {
      this.ingredients.forEach(ingredient => {
        // eslint-disable-next-line no-magic-numbers
        ingredient.inventory = Math.round(ingredient.inventory * 100) / 100;
      });
    },
    toggleAddModal() {
      if (this.invisible) {
        this.toggleSearchIngredientsModal();
        this.makeInvisible();
      }
      this.cleanErrors();
      this.showingAdd = !this.showingAdd;
      this.marketIngredient = undefined;
    },

    goBackAddModal() {
      if (this.invisible) {
        this.makeInvisible();
      }
      if (this.marketIngredient) {
        this.showingAdd = !this.showingAdd;
      } else {
        // Aqui arreglar si se vuelve a la pagina principal o no
        this.showingAdd = !this.showingAdd;
      }
    },

    toggleSearchIngredientsModal() {
      this.showingSearchIngredients = !this.showingSearchIngredients;
    },

    toggleEditModal(ingredient) {
      this.cleanErrors();
      this.showingEdit = !this.showingEdit;
      this.ingredientToEdit = ingredient;
    },

    toggleDelModal(ingredient) {
      this.showingDel = !this.showingDel;
      this.ingredientToDelete = ingredient;
      if (this.showingDel) {
        this.getIngredientAssociations(ingredient.id);
      }
    },
    goToEditInventories() {
      window.location = '/ingredients/update-inventories';
    },

    async getIngredientAssociations(ingredientId) {
      this.loadingAssociations = true;
      try {
        const response = await getCriticalAssociations(ingredientId);
        this.criticalAssociations = response.data.recipes.map((element) => element.name);
      } catch (error) {
        this.unexpectedError = true;
      } finally {
        this.loadingAssociations = false;
      }
    },

    // eslint-disable-next-line max-statements
    async validateAddIngredient() {
      if (this.validations(this.$refs.addIngredientInfo.form)) {
        const ingredientsInfo = this.$refs.addIngredientInfo.form;
        if (ingredientsInfo.minimumQuantity === undefined) {
          ingredientsInfo.minimumQuantity = 0;
        }
        try {
          this.showingAdd = !this.showingAdd;
          this.loading = true;
          ingredientsInfo.ingredientMeasuresAttributes = ingredientsInfo
            .ingredientMeasuresAttributes.filter(unit => unit.name && unit.quantity);
          const {
            data:
            { data: { id, attributes },
            },
          } = await postIngredient(ingredientsInfo);
          this.ingredients.push({ id, ...attributes });
        } catch (error) {
          this.unexpectedError = true;
        } finally {
          this.loading = false;
        }
      }
    },

    async addIngredient() {
      this.toggleSearchIngredientsModal();
      this.makeInvisible();
      this.validateAddIngredient();
    },

    makeInvisible() {
      this.invisible = !this.invisible;
    },

    async addMarketIngredient(productForm) {
      this.cleanErrors();
      this.showingAdd = !this.showingAdd;
      this.marketIngredient = undefined;
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
      const ingredientsInfo = this.$refs.editIngredientInfo.form;
      if (this.validations(this.$refs.editIngredientInfo.form)) {
        try {
          this.showingEdit = !this.showingEdit;
          this.loading = true;
          ingredientsInfo.ingredientMeasuresAttributes = ingredientsInfo
            .ingredientMeasuresAttributes.filter(unit => unit.name && unit.quantity);
          this.addMeasuresToDelete(ingredientsInfo);
          const ingredientsInfoFinal = this.addInventoryToIngredient(ingredientsInfo, this.ingredientToEdit.id);
          await editIngredient(this.ingredientToEdit.id, ingredientsInfoFinal);
          this.updateIngredient(ingredientsInfoFinal);
        } catch (error) {
          this.unexpectedError = true;
        } finally {
          this.loading = false;
        }
      }
    },

    addMeasuresToDelete(ingredientsInfo) {
      this.$refs.editIngredientInfo.measuresToDelete
        .forEach(elem => ingredientsInfo.ingredientMeasuresAttributes.push({ id: elem, _destroy: true }));
    },

    async deleteIngredient() {
      this.showingDel = !this.showingDel;
      this.loading = true;
      try {
        await deleteIngredient(this.ingredientToDelete.id);
        this.ingredients = this.ingredients.filter(item => item.id !== this.ingredientToDelete.id);
      } catch (error) {
        this.unexpectedError = true;
      } finally {
        this.loading = false;
      }
    },
    async UpdateInventory(ingredient) {
      try {
        await editIngredient(ingredient.id, { 'inventory': ingredient.inventory });
      } catch (error) {
        this.unexpectedError = true;
      }
    },
    async updateMinimumQuantity(ingredient) {
      try {
        await editIngredient(ingredient.id, { 'minimumQuantity': ingredient.minimumQuantity });
      } catch (error) {
        this.unexpectedError = true;
      }
    },

    async updateIngredient(ingredientEdited) {
      ingredientEdited.quantity = ingredientEdited.ingredientMeasuresAttributes[0].quantity;
      ingredientEdited.measure = ingredientEdited.ingredientMeasuresAttributes[0].name;
      ingredientEdited.id = this.ingredientToEdit.id;
      ingredientEdited.otherMeasures = { data: [] };
      ingredientEdited.providerName = ingredientEdited.provider_name;
      ingredientEdited.ingredientMeasuresAttributes.forEach(element => {
        ingredientEdited.otherMeasures.data
          .push({ id: element.id, attributes: { name: element.name, quantity: element.quantity } });
      });
      const objectIndex = this.ingredients.findIndex((obj => obj.id === this.ingredientToEdit.id));
      Vue.set(this.ingredients, objectIndex, ingredientEdited);
    },

    cleanErrors() {
      this.errors = {
        name: '',
        quantity: [],
        measure: [],
        price: '',
        minimumQuantity: '',
      };
    },

    validations(form) {
      this.cleanErrors();
      const correctMeasures = this.measuresValidations(form);

      this.errors.price = intGeqZero(form.price, this.errors.price);
      this.errors.minimumQuantity = geqZero(form.minimumQuantity, this.errors.minimumQuantity);
      this.errors.name = requiredField(form.name, this.errors.name);
      this.errors.price = requiredField(form.price, this.errors.price);

      return correctMeasures && !(Object.values(this.errors).some(value => !!value));
    },

    measuresValidations(form) {
      let correct = this.duplicatedMeasuresValidations(form);

      form.ingredientMeasuresAttributes.forEach((pair, idx) => {
        this.errors.quantity[idx] = requiredField(pair.quantity, this.errors.quantity[idx]);
        this.errors.quantity[idx] = floatNonZero(pair.quantity, this.errors.quantity[idx]);
        this.errors.measure[idx] = requiredField(pair.name, this.errors.measure[idx]);

        if (!!this.errors.measure[idx] || !!this.errors.quantity[idx]) {
          correct = false;
        }
      });

      return correct;
    },

    duplicatedMeasuresValidations(form) {
      let correct = true;
      const auxiliaryMeasureAttributes = JSON.parse(JSON.stringify(form.ingredientMeasuresAttributes));
      const names = auxiliaryMeasureAttributes.map((unit) => unit.name.toLowerCase());

      auxiliaryMeasureAttributes.forEach((pair, idx) => {
        if (names.filter((value) => value === pair.name.toLowerCase()).length > 1) {
          this.errors.measure[idx] = 'duplicatedMeasure';
          correct = false;
        }
      });

      return correct;
    },
  },
};
</script>
