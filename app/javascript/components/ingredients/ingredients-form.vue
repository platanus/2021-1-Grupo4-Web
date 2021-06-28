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
            v-model="form.provider_name"
            id="ingredient-provider"
          >
            <!--Add Mode unit from market -->
            <option
              v-if="!editMode && marketIngredient !== undefined"
              selected
              :key="form.provider_name"
              :value="form.provider_name"
            >
              {{ form.provider_name }}
            </option>
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
      <div
        v-for="(unit, index) in form.ingredient_measures_attributes"
        :key="index"
      >
        <div
          v-if="index == 0"
        >
          {{ $t('msg.ingredients.defaultUnit') }}
        </div>
        <div
          v-if="index == 1"
        >
          {{ $t('msg.ingredients.alternativeUnit') }}
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
              min="1"
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
            <div class="flex">
              <select
                class="block appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4 pr-8
                rounded leading-tight focus:outline-none"
                v-model="unit.name"
              >
                <!--Add Mode unit from market -->
                <option
                  v-if="!editMode && marketIngredient !== undefined"
                  hidden
                  selected
                  :key="form.ingredient_measures_attributes[0].name"
                  :value="form.ingredient_measures_attributes[0].name"
                >
                  {{ form.ingredient_measures_attributes[0].name }}
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
                  v-for="form_unit in formUnits"
                  :key="form_unit"
                  :value="form_unit"
                >
                  {{ form_unit }}
                </option>
              </select>

              <button
                type="button"
                class="px-3"
                v-if="index > 0"
                @click="deleteUnit(unit)"
              >
                <img
                  class="h-9 w-9 text-white m-auto"
                  svg-inline
                  src="../../../assets/images/cross-svg.svg"
                >
              </button>
            </div>
          </div>
        </div>
        <div
          v-if="index == form.ingredient_measures_attributes.length - 1"
        >
          <button
            type="button"
            @click="AddMeasure"
            class="mb-6 bg-yellow-500 hover:bg-yellow-600 text-white p-2 rounded text-sm font-medium"
          >
            {{ $t('msg.ingredients.addUnit') }}
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

import { getProviders } from './../../api/providers.js';

export default {
  props: {
    editMode: { type: Boolean, required: true },
    ingredient: { type: Object, default() {
      return {};
    } },
    units: { type: Array, required: true },
    marketIngredient: { type: Object, default: undefined },
  },

  data() {
    return {
      form: {
        provider_name: null, /* eslint-disable-line camelcase */
        name: '',
        sku: null,
        price: '',
        currency: 'CLP',
        ingredient_measures_attributes: [], /* eslint-disable-line camelcase */
      },
      showingMeasureModal: false,
      providersNames: [],
      usedUnits: [],
      measuresToDelete: [],
    };
  },
  methods: {
    AddMeasure() {
      const lastItem = this.form.ingredient_measures_attributes[this.form.ingredient_measures_attributes.length - 1];
      if (lastItem.name && lastItem.quantity) {
        this.form.ingredient_measures_attributes.push({ name: undefined, quantity: undefined, id: undefined });
      }
    },
    deleteUnit(unit) {
      this.form.ingredient_measures_attributes = this.form /* eslint-disable-line camelcase */
        .ingredient_measures_attributes.filter((originalUnit) => originalUnit !== unit);
      if (unit.id !== undefined) {
        this.measuresToDelete.push(unit.id);
      }
    },
  },
  async created() {
    if (this.marketIngredient === undefined) {
      const {
        providerName,
        name,
        sku,
        price,
        currency,
        otherMeasures,
      } = this.ingredient;
      let ingredient_measures_attributes; /* eslint-disable-line camelcase */
      if (otherMeasures) {
        ingredient_measures_attributes = otherMeasures.data.map(unit => /* eslint-disable-line camelcase */
          Object.assign({}, { id: unit.id }, unit.attributes),
        );
      } else {
        ingredient_measures_attributes = [{ /* eslint-disable-line camelcase */
          name: undefined, quantity: undefined, id: undefined,
        }];
      }
      this.form = {
        provider_name: providerName, /* eslint-disable-line camelcase */
        name,
        sku,
        price,
        currency,
        ingredient_measures_attributes, /* eslint-disable-line camelcase */
      };
    } else {
      this.form = this.marketIngredient;
    }

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
