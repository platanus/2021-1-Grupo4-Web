<template>
  <div class="flex flex-col">
    <div class="flex items-center">
      <!--Title-->
      <div class="text-4xl font-bold">
        {{ $t('msg.ingredients.title') }}
      </div>
      <span
        class="flex m-auto w-8 h-8 ml-2"
        v-if="loading"
      >
        <base-spinner />
      </span>
    </div>

    <!-- Alert -->
    <div
      v-if="unexpectedError"
      class="mt-4 w-max bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative"
      role="alert"
    >
      <span class="mr-7 block sm:inline">{{ $t('msg.unexpectedError') }}</span>
      <span
        class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer"
        @click="closeAlert"
      >
        <img
          svg-inline
          src="../../../assets/images/cancel-red-svg.svg"
          class="h-5 w-5 text-red-700"
        >
      </span>
    </div>

    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 my-10">
      <!--SearchBar y Button-->
      <div class="flex flex-col lg:flex-row pb-4">
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

    async validateAddIngredient() {
      if (this.validations(this.$refs.addIngredientInfo.form)) {
        const ingredientsInfo = this.$refs.addIngredientInfo.form;
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
      if (this.checkErrorsEditIngredient(ingredientsInfo)) {
        return;
      }
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
    checkErrorsEditIngredient(info) {
      if (!info.name || !info.ingredientMeasuresAttributes[0].quantity ||
      !info.ingredientMeasuresAttributes[0].name) {
        // eslint-disable-next-line no-alert
        alert(this.$t('msg.ingredients.msjAlert'));

        return true;
      } else if (info.ingredientMeasuresAttributes[0].quantity < 1) {
        // eslint-disable-next-line no-alert
        alert(this.$t('msg.ingredients.msjMinQuantity'));

        return true;
      } else if (info.minimumQuantity < 0) {
        // eslint-disable-next-line no-alert
        alert(this.$t('msg.ingredients.msjNegativeQuantity'));

        return true;
      }

      return false;
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
        quantity: '',
        measure: '',
        price: '',
        minimumQuantity: '',
      };
    },

    // eslint-disable-next-line max-statements,complexity
    validations(form) {
      this.cleanErrors();

      const quantity = form.ingredientMeasuresAttributes[0].quantity;

      if (!(typeof (quantity - 0) === 'number') || !(quantity > 0)) {
        this.errors.quantity = 'floatNonZero';
      }

      if (!(Number.isInteger(form.price - 0)) || !(form.price >= 0)) {
        this.errors.price = 'intGeqZero';
      }

      if (form.minimumQuantity && !(form.minimumQuantity >= 0)) {
        this.errors.minimumQuantity = 'geqZero';
      }

      if (!form.name) {
        this.errors.name = 'requiredField';
      }

      if (!form.ingredientMeasuresAttributes[0].quantity) {
        this.errors.quantity = 'requiredField';
      }

      if (!form.ingredientMeasuresAttributes[0].name) {
        this.errors.measure = 'requiredField';
      }

      if (!form.price) {
        this.errors.price = 'requiredField';
      }

      const validForm = !(Object.values(this.errors).some(value => !!value));

      return validForm;
    },
  },
};
</script>
