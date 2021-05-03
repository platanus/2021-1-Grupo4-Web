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

import axios from 'axios';

export default {

  data() {
    return {
      showingAdd: false,
      showingEdit: false,
      showingDel: false,
      ingredientToEdit: {},
      tableHeader: ['name', 'price', 'quantity', 'measure'],
      ingredients: [],
      status: '',
      error: '',
      response: '',
    };
  },

  mounted() {
    const token = localStorage.getItem('token');
    const email = localStorage.getItem('email');

    axios
      .get('https://pl-super-kitchen-staging.herokuapp.com/api/v1/ingredients', { params: {
        'user_email': email,
        'user_token': token,
      } })
      .then(response => {
        this.status = response.status;
        this.error = '';
        this.response = response;
      })
      .catch(error => {
        this.status = 400;
        this.error = error;
      });
  },

  methods: {
    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
    },
    toggleEditModal(ingredient) {
      this.showingEdit = !this.showingEdit;
      this.ingredientToEdit = ingredient;
    },
    toggleDelModal() {
      this.showingDel = !this.showingDel;
    },
    addIngredient() {
      this.showingAdd = !this.showingAdd;
    },
    editIngredient() {
      this.showingEdit = !this.showingEdit;
    },
    deleteIngredient() {
      this.showingDel = !this.showingDel;
    },
  },
};
</script>
