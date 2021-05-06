/* eslint-disable no-console */
<template>
  <div>
    <!--Title-->
    <h2 class="text-4xl">
      {{ $t('msg.ingredients.title') }}
    </h2>

    <!--SearchBar y Button-->
    <div class="flex items-center">
      <search
        kind="ingredient"
        :placeholder="$t('msg.ingredients.search')"
      />
      <base-button
        :elements="{ placeholder: $t('msg.ingredients.add'),
                     color: 'bg-green-500 hover:bg-green-700 text-white' }"
        @click="toggleAddModal"
      />
    </div>

    <!--Table-->
    <div class="flex items-center">
      <p
        v-if="this.ingredients.length===0"
      >
        {{ $t('msg.notElements') }} {{ $t('msg.ingredients.title') }}
      </p>
      <base-table
        v-else
        :dots="true"
        :header="tableHeader"
        :body="this.ingredients"
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
        ref="ingredientInfo"
        :units="['Kg','Litro']"
        :edit-mode="false"
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

import { getIngredients, postIngredient, deleteIngredient } from './../../ingredientsRequests.js';

export default {

  data() {
    return {
      showingAdd: false,
      showingEdit: false,
      showingDel: false,
      ingredientToEdit: {},
      ingredientToDelete: {},
      tableHeader: ['name', 'price', 'quantity', 'measure'],
      ingredients: [],
      status: '',
      error: '',
      response: '',
    };
  },

  async created() {
    const token = localStorage.getItem('token');
    const email = localStorage.getItem('email');

    try {
      const response = await getIngredients(email, token);
      this.status = response.status;
      this.error = '';
      this.response = response;
      this.ingredients = response.data.data.map(function(element) {
        return {
          id: element.id,
          ...element.attributes,
        }
      });
    } catch (error) {
      this.status = error.response.status;
      this.error = error;
    }
  },

  methods: {
    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
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
      const newIngredient = this.$refs.ingredientInfo.form;
      const token = localStorage.getItem('token');
      const email = localStorage.getItem('email');

      this.showingAdd = !this.showingAdd;

      try {
        const response = await postIngredient(newIngredient, email, token);
        this.ingredients.push(response.data.data.attributes);
      } catch (error) {
        this.status = error.response.status;
        this.error = error;
      }
    },
    editIngredient() {
      this.showingEdit = !this.showingEdit;
    },
    async deleteIngredient() {
      this.showingDel = !this.showingDel;
      const token = localStorage.getItem('token');
      const email = localStorage.getItem('email');
      console.log(token, email, this.ingredientToDelete.id);
      try {
        const response = await deleteIngredient(email, token, this.ingredientToDelete.id);
        this.ingredients = this.ingredients.filter(item => item.id !== this.ingredientToDelete.id);
      } catch (error) {
        this.status = error.response.status;
        this.error = error;
      }
    },
  },
};
</script>
