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
          <base-error-paragraph
            :msg-error="ingredientErrors.name"
          />
        </div>
      </div>

      <div
        class="flex flex-wrap -mx-3 mb-6"
      >
        <div class="w-full px-3">
          <!--Provider Name -->
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
            <!--Add Mode unit from market -->
            <option
              v-if="!editMode && marketIngredient !== undefined"
              selected
              :key="form.providerName"
              :value="form.providerName"
            >
              {{ form.providerName }}
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
        v-for="(unit, index) in form.ingredientMeasuresAttributes"
        :key="index"
      >
        <div
          class="mb-2 text-gray-700 text-sm font-bold"
          v-if="index == 0"
        >
          {{ $t('msg.ingredients.defaultUnit') }}
        </div>
        <div
          class="mb-2 text-gray-700 text-sm font-bold"
          v-if="index == 1"
        >
          {{ $t('msg.ingredients.alternativeUnit') }}
        </div>
        <div class="flex -mx-3">
          <div class="w-full md:w-2/5 px-3 mb-0 md:mb-6">
            <!--Quantity -->
            <label
              v-if="index == 0 || index == 1"
              class="block text-gray-700 text-sm font-bold mb-2"
              for="ingredient-quantity"
            >
              {{ $t('msg.ingredients.quantity') }}
            </label>
            <input
              class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none"
              v-model="unit.quantity"
              min="1"
              type="number"
              :placeholder="unit.name"
              @change="autoAddUnit(unit)"
            >
            <base-error-paragraph
              :msg-error="ingredientErrors.quantity"
            />
          </div>
          <div class="w-full px-3 mb-6 md:mb-0">
            <!--Measure -->
            <label
              v-if="index == 0 || index == 1"
              class="block text-gray-700 text-sm font-bold mb-2"
              for="ingredient-unit"
            >
              {{ $t('msg.ingredients.measure') }}
            </label>
            <div class="flex">
              <measure-search
                v-if="!editMode && marketIngredient !== undefined"
                :selected-measure="unit.name"
                @selectMeasure="changeUnitName(unit, ...arguments)"
              />
              <measure-search
                v-if="!editMode && marketIngredient === undefined"
                :selected-measure="unit.name"
                @selectMeasure="changeUnitName(unit, ...arguments)"
              />
              <measure-search
                v-if="editMode"
                :selected-measure="unit.name"
                @selectMeasure="changeUnitName(unit, ...arguments)"
              />
              <button
                type="button text-black"
                class="px-3"
                v-if="index > 0"
                @click="deleteUnit(unit)"
              >
                <img
                  class="h-5 w-5 m-auto"
                  svg-inline
                  src="../../../assets/images/cross-svg.svg"
                >
              </button>
            </div>
            <base-error-paragraph
              :msg-error="ingredientErrors.measure"
            />
          </div>
        </div>
        <div
          v-if="index == form.ingredientMeasuresAttributes.length - 1"
        >
          <button
            type="button"
            @click="addMeasure"
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
          <base-error-paragraph
            :msg-error="ingredientErrors.price"
          />
          <!--Minimum Quantity -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2 mt-4"
            for="ingredient-minimumQuantity"
          >
            <div
              v-if="form.ingredientMeasuresAttributes[0].name"
            >
              {{ $t('msg.ingredients.minimumQuantity') + " (en "+ form.ingredientMeasuresAttributes[0].name +")" }}
            </div>
            <div
              v-else
            >
              {{ $t('msg.ingredients.minimumQuantity') + " (en Unidad por defecto)" }}
            </div>
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="ingredient-minimumQuantity"
            v-model="form.minimumQuantity"
            type="number"
            :placeholder="$t('msg.ingredients.quantity')"
          >
          <base-error-paragraph
            :msg-error="ingredientErrors.minimumQuantity"
          />
        </div>
      </div>
    </form>
  </div>
</template>

<script>

import { getProviders } from './../../api/providers.js';
import MeasureSearch from './measure_search';

export default {
  props: {
    ingredientErrors: { type: Object, required: true },
    editMode: { type: Boolean, required: true },
    ingredient: { type: Object, default() {
      return {};
    } },
    marketIngredient: { type: Object, default: undefined },
  },
  components: {
    MeasureSearch,
  },
  data() {
    return {
      form: {
        providerName: null,
        name: '',
        sku: null,
        price: '',
        currency: 'CLP',
        ingredientMeasuresAttributes: [],
      },
      directConvertions: {
        Gramo: { Kilo: 1000 },
        Kilo: { Gramo: 0.001 },
        Litro: { Mililitro: 0.001 },
        Mililitro: { Litro: 1000 },
        Taza: { Cucharada: 0.0625, Cucharadita: 0.020833 },
        Cucharada: { Cucharadita: 0.333, Taza: 16 },
        Cucharadita: { Taza: 48, Cucharada: 3 },
      },
      showingMeasureModal: false,
      providersNames: [],
      measuresToDelete: [],
    };
  },
  methods: {
    addMeasure() {
      const lastItem = this.form.ingredientMeasuresAttributes[this.form.ingredientMeasuresAttributes.length - 1];
      if (lastItem.name && lastItem.quantity) {
        this.form.ingredientMeasuresAttributes.push({ name: undefined, quantity: undefined, id: undefined });
      }
    },
    deleteUnit(unit) {
      this.form.ingredientMeasuresAttributes = this.form
        .ingredientMeasuresAttributes.filter((originalUnit) => originalUnit !== unit);
      if (unit.id !== undefined) {
        this.measuresToDelete.push(unit.id);
      }
    },
    changeUnitName(unit, measure) {
      unit.name = measure;
      this.autoAddUnit(unit);
    },
    autoAddUnit(currentUnit) {
      const decimals = 100; // la cantidad de 0s es la cantidad de decimales que tendrá la conversion.
      const presentUnits = this.form.ingredientMeasuresAttributes.map((unit) => unit.name);
      if (this.directConvertions[currentUnit.name] && currentUnit.quantity !== undefined) {
        Object.keys(this.directConvertions[currentUnit.name]).forEach((unit) => {
          if (presentUnits.includes(unit)) {
            const unitsToUpdate = this.form.ingredientMeasuresAttributes.filter((obj) => obj.name === unit);
            for (const unitToUpdate of unitsToUpdate) {
              unitToUpdate.quantity = Math.round(
                currentUnit.quantity * decimals / this.directConvertions[currentUnit.name][unit]) / decimals;
            }
          } else {
            this.pushAutoUnit(
              unit,
              Math.round(currentUnit.quantity * decimals / this.directConvertions[currentUnit.name][unit]) / decimals);
          }
        });
      }
    },
    pushAutoUnit(name, quantity) {
      const lastItem = this.form.ingredientMeasuresAttributes[this.form.ingredientMeasuresAttributes.length - 1];
      if (!lastItem.name || !lastItem.quantity) {
        this.form.ingredientMeasuresAttributes.pop(-1);
        this.form.ingredientMeasuresAttributes.push({ name, quantity, id: undefined });
        this.form.ingredientMeasuresAttributes.push(lastItem);
      } else {
        this.form.ingredientMeasuresAttributes.push({ name, quantity, id: undefined });
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
        minimumQuantity,
        otherMeasures,
      } = this.ingredient;
      let ingredientMeasuresAttributes;
      if (otherMeasures) {
        ingredientMeasuresAttributes = otherMeasures.data.map(unit =>
          Object.assign({}, { id: unit.id }, unit.attributes),
        );
      } else {
        ingredientMeasuresAttributes = [{
          name: undefined, quantity: undefined, id: undefined,
        }];
      }
      this.form = {
        providerName,
        name,
        sku,
        price,
        currency,
        minimumQuantity,
        ingredientMeasuresAttributes,
      };
    } else {
      this.form = this.marketIngredient;
    }

    const providers = await getProviders();
    this.providersNames = providers.data.data.map((provider) => provider.attributes.name);
  },
};

</script>
