/* eslint-disable no-console */
<template>
  <div>
    <!--Title-->
    <h2 class="text-4xl">
      {{ $t('msg.ingredients.title') }}
    </h2>

    <!--SearchBar y Button-->
    <div class="flex items-center">
      <input
        class="border-2 w-1/4 border-yellow-700 py-2 text-sm text-yellow-700 px-2 focus:outline-none focus:bg-white focus:text-yellow-700"
        :placeholder="$t('msg.ingredients.search')"
        @keyup.enter="filterIngredients"
        v-model="searchQuery"
      >
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
      <base-table
        v-else
        :dots="true"
        :header="tableHeader"
        :body="filterIngredients()"
        model-type="ingredients"
        @edit="toggleEditModal"
        @del="toggleDelModal"
      />
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
</template>

<script>

import { getIngredients, postIngredient, deleteIngredient, editIngredient } from './../../api/ingredients.js';
import IngredientsForm from './ingredients-form';
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
      tableHeader: ['name', 'price', 'quantity', 'measure'],
      searchQuery: null,
      ingredients: [],
      error: '',
    };
  },

  components: {
    IngredientsForm,
    SearchMarketIngredients,
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
          data:
            { data: { id, attributes },
            },
        } = await postIngredient(this.$refs.addIngredientInfo.form);
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
        const res = await editIngredient(this.ingredientToEdit.id, this.$refs.editIngredientInfo.form);
        this.updateIngredient(res);
        this.error = '';
      } catch (error) {
        this.error = error;
      }
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

    async updateIngredient(res) {
      const ingredientEdited = { id: this.ingredientToEdit.id, ...JSON.parse(res.config.data).ingredient };
      const objectIndex = this.ingredients.findIndex((obj => obj.id === this.ingredientToEdit.id));
      this.ingredients.splice(objectIndex, 1);
      this.ingredients.splice(objectIndex, 0, ingredientEdited);
    },

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
};
</script>
