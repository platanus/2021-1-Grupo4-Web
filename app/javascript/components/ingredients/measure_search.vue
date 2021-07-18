<template>
  <div class="relative">
    <input
      class="block appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4
      rounded leading-tight focus:outline-none"
      v-model="query"
      @focus="toggleFocusInput"
      @blur="toggleFocusInput"
      @change="emitSelectedMeasure(query)"
    >
    <div
      v-if="focusedInput"
      class="z-20 absolute appearance-none w-full bg-white border border-gray-200 text-gray-700 py-3 px-4 pr-8
                rounded leading-tight focus:outline-none"
    >
      <div class="flex flex-col max-h-64 overflow-y-auto">
        <div
          v-if="!sameQueryInOptions && query.length > 0"
          class="px-1 py-2 hover:underline cursor-pointer w-full text-yellow-600 font-light"
        >
          {{ `${$t('msg.ingredients.newMeasure')} '${query}'` }}
        </div>
        <div
          v-for="(measure, idx) in measuresFound"
          :key="idx"
          class="p-1 py-2 hover:bg-gray-100 cursor-pointer w-full"
          @mousedown="emitSelectedMeasure(measure)"
        >
          {{ measure }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: {
    selectedMeasure: { type: String, required: false, default: '' },
  },

  data() {
    return {
      availableMeasures: ['Kilo', 'Gramo', 'Cucharada', 'Cucharadita', 'Taza', 'Litro', 'Mililitro', 'Oz', 'Unidad'],
      query: this.selectedMeasure,
      focusedInput: false,
    };
  },
  methods: {
    toggleFocusInput() {
      this.focusedInput = !this.focusedInput;
    },
    emitSelectedMeasure(measure) {
      this.query = measure;
      this.$emit('selectMeasure', measure);
    },
  },
  computed: {
    measuresFound() {
      if (this.availableMeasures) {
        return this.availableMeasures.filter(item => this.query
          .toLowerCase()
          .split(' ')
          .every(text => item.toLowerCase().includes(text)));
      }

      return this.availableMeasures;
    },
    sameQueryInOptions() {
      for (let idx = 0; idx < this.measuresFound.length; idx++) {
        if (this.measuresFound[idx].toLowerCase() === this.query.toLowerCase()) {
          return true;
        }
      }

      return false;
    },
  },
  watch: {
    selectedMeasure() {
      this.query = this.selectedMeasure;
    },
  },
};

</script>
