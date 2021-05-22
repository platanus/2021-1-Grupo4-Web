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
        <div class="relative">
          <!--Measure -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="ingredient-unit"
          >
            {{ $t('msg.ingredients.measure') }}
          </label>
          <select
            class="appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4 pr-8
            rounded leading-tight focus:outline-none bg-none"
            id="ingredient-unit"
            v-model="form.measure"
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

          <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
            <svg
              class="fill-current h-4 w-4"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 20 20"
            ><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
          </div>
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

export default {
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
        name: '',
        sku: null,
        price: '',
        currency: 'CLP',
        quantity: '',
        measure: '',
      },
    };
  },

  created() {
    const {
      providerId,
      name,
      sku,
      price,
      currency,
      quantity,
      measure,
    } = this.ingredient;

    this.form = {
      providerId,
      name,
      sku,
      price,
      currency,
      quantity,
      measure,
    };
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
