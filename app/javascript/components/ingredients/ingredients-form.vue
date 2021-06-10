<template>
  <div class="pt-3">
    <form class="w-full max-w-lg">
      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <!--Name -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="ingredient-name"
          >
            {{ $t('msg.ingredients.name') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="ingredient-name"
            type="text"
            :placeholder="$t('msg.ingredients.name')"
            v-model="form.name"
          >
        </div>
      </div>

      <div
        class="flex flex-wrap -mx-3 mb-6"
        v-if="!editMode"
      >
        <div class="w-full px-3">
          <!--Name -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-name"
          >
            {{ $t('msg.ingredients.providerName') }}
          </label>
          <select
            class="block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            v-model="form.providerName"
            id="ingredient-provider"
          >
            <option
              v-for="(name, idx) in providersNames"
              :key="idx"
              :value="name"
            >
              {{ name }}
            </option>
          </select>
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <!--Quantity -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="ingredient-quantity"
          >
            {{ $t('msg.ingredients.quantity') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            v-model="form.quantity"
            id="ingredient-amount"
            type="number"
            :placeholder="$t('msg.ingredients.quantity')"
          >
        </div>
      </div>
      <div
        v-for="(unit, index) in form.ingredient_measures_attributes"
        :key="index"
      >
        <div
          v-if="index == 0"
        >
          {{ $t('msg.ingredients.default_unit') }}
        </div>
        <div
          v-if="index == 1"
        >
          {{ $t('msg.ingredients.alternative_unit') }}
        </div>
        <div class="flex flex-wrap -mx-3">
          <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
            <!--Quantity -->
            <label
              v-if="index == 0 || index == 1"
              class="block text-gray-700 text-sm font-bold mb-2"
              for="ingredient-quantity"
            >
              {{ $t('msg.ingredients.quantity') }}
            </label>
            <input
              class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
              v-model="unit.quantity"
              id="ingredient-amount"
              type="number"
              :placeholder="$t('msg.ingredients.quantity')"
            >
          </div>
          <div class="relative">
            <!--Measure -->
            <label
              v-if="index == 0 || index == 1"
              class="block text-gray-700 text-sm font-bold mb-2"
              for="ingredient-unit"
            >
              {{ $t('msg.ingredients.measure') }}
            </label>
            <select
              class="block appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4 pr-8
              rounded leading-tight focus:outline-none"
              id="ingredient-unit"
              v-model="unit.name"
            >
              <!--Add Mode unit Unselected -->
              <option
                v-if="!editMode"
                hidden
                selected
              >
                {{ $t('msg.ingredients.measure') }}
              </option>
              <!--Edit Mode unit ingredient -->
              <option
                v-if="editMode"
                selected
                :key="ingredient.measure"
                :value="ingredient.measure"
              >
                {{ ingredient.measure }}
              </option>
              <!--Other units -->
              <option
                v-for="unit in formUnits"
                :key="unit"
                :value="unit"
              >
                {{ unit }}
              </option>
            </select>
            <button
              type="button"
              v-if="index > 0"
              @click="deleteUnit(unit)"
            >
              x
            </button>
          </div>
          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
            <svg
              class="fill-current h-4 w-4"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
            ><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
          </div>
        </div>
        <div
          v-if="index == form.ingredient_measures_attributes.length - 1"
        >
          <button
            type="button"
            @click="AddMeasure"
          >
            Agregatee
          </button>
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <!--Price -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="ingredient-price"
          >
            {{ $t('msg.ingredients.price') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="ingredient-price"
            v-model="form.price"
            type="number"
            :placeholder="$t('msg.ingredients.price')"
          >
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import baseModal from '../base/base-modal.vue';

import { getProviders } from './../../api/providers.js';

export default {
  components: { baseModal },
  props: {
    editMode: { type: Boolean, required: true },
    ingredient: { type: Object, default() {
      return {};
    } },
    units: { type: Array, required: true },
  },

  data() {
    return {
      form: {
        providerId: null,
        providerName: null,
        name: '',
        sku: null,
        price: '',
        currency: 'CLP',
        ingredient_measures_attributes: [],
      },
      showingMeasureModal: false,
      providersNames: [],
      usedUnits: [],
    };
  },
  methods: {
    AddMeasure() {
      const last_item = this.form.ingredient_measures_attributes[this.form.ingredient_measures_attributes.length -1];
      if(last_item.name && last_item.quantity){
        this.form.ingredient_measures_attributes.push({ name: undefined, quantity: undefined, id: undefined });
      }
    },
    deleteUnit(unit) {
      this.form.ingredient_measures_attributes = this.form.ingredient_measures_attributes.filter((originalUnit) => originalUnit !== unit);
    },
  },
  async created() {
    var {
      providerId,
      name,
      sku,
      price,
      currency,
      otherMeasures,
    } = this.ingredient;
    var ingredient_measures_attributes;
    if(!otherMeasures){
      ingredient_measures_attributes = [{ name: undefined, quantity: undefined, id: undefined }];
    }else{
      ingredient_measures_attributes = otherMeasures.data.map(function(unit) {
        return Object.assign({}, {id: unit.id}, unit.attributes);
      });
    }
    this.form = {
      providerId,
      name,
      sku,
      price,
      currency,
      ingredient_measures_attributes,
    };

    const providers = await getProviders();
    this.providersNames = providers.data.data.map((provider) => provider.attributes.name);
  },

  computed: {
    formUnits() {
      if (!this.editMode) {
        return this.units;
      }

      return this.units.filter(unit => unit !== this.ingredient.measure);
    },
  },
};

</script>
