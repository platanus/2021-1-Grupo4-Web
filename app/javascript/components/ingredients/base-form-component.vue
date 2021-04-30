<template>
  <div class="pt-3">
    <form class="w-full max-w-lg">
      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <input-form
            id="ingredient-name"
            type="text"
            :placeholder="$t('msg.ingredients.name')"
            :value="editMode ? ingredient.name : ''"
          />
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <input-form
            id="ingredient-amount"
            type="number"
            :placeholder="$t('msg.ingredients.quantity')"
            :value="editMode ? ingredient.quantity : ''"
          />
        </div>
        <div class="relative">
          <select
            class="block appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4 pr-8
            rounded leading-tight focus:outline-none"
            id="ingredient-unit"
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
          <input-form
            id="ingredient-price"
            type="number"
            :placeholder="$t('msg.ingredients.price')"
            :value="editMode? ingredient.price : ''"
          />
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
