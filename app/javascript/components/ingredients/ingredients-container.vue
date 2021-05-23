/* eslint-disable no-console */
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
          <ingredients-search-bar
            kind="ingredient"
            :placeholder="$t('msg.ingredients.search')"
          />
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
            :ingredients="this.ingredients"
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
          :units="['Kg','Litro']"
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
          :units="['Kg','Litro']"
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

import { getIngredients, postIngredient, deleteIngredient, editIngredient } from './../../api/ingredients.js';
import IngredientsSearchBar from './ingredients-search-bar';
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
      status: '',
      error: '',
    };
  },

  components: {
    IngredientsSearchBar,
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
      this.successResponse(response);
    } catch (error) {
      this.errorResponse(error);
    }
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
      this.showingAdd = !this.showingAdd;

      try {
        const {
          status,
          data:
            { data: { id, attributes },
            },
        } = await postIngredient(this.$refs.addIngredientInfo.form);
        const ingredientToAdd = { id, ...attributes };
        this.ingredients.push(ingredientToAdd);
        this.successResponse(status);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async addMarketIngredient(productForm) {
      this.toggleSearchIngredientsModal();

      try {
        const {
          status,
          data:
            {
              data: { id, attributes },
            },
        } = await postIngredient(productForm);
        const ingredientToAdd = { id, ...attributes };
        this.ingredients.push(ingredientToAdd);
        this.successResponse(status);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async editIngredient() {
      this.showingEdit = !this.showingEdit;
      try {
        const res = await editIngredient(this.ingredientToEdit.id, this.$refs.editIngredientInfo.form);
        this.updateIngredient(res);
        this.successResponse(res);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async deleteIngredient() {
      this.showingDel = !this.showingDel;
      try {
        const response = await deleteIngredient(this.ingredientToDelete.id);
        this.ingredients = this.ingredients.filter(item => item.id !== this.ingredientToDelete.id);
        this.successResponse(response);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async updateIngredient(res) {
      const ingredientEdited = { id: this.ingredientToEdit.id, ...JSON.parse(res.config.data).ingredient };
      const objectIndex = this.ingredients.findIndex((obj => obj.id === this.ingredientToEdit.id));
      this.ingredients.splice(objectIndex, 1);
      this.ingredients.splice(objectIndex, 0, ingredientEdited);
    },

    async successResponse(status) {
      this.status = status;
      this.error = '';
    },

    async errorResponse(error) {
      this.status = error.response.status;
      this.error = error;
    },
  },
};
</script>
