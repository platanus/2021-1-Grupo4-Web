<template>
  <div>
    <div
      v-if="input"
      :class="color ? 'bg-white' : 'bg-gray-100'"
    >
      <div
        class="p-4 items-center justify-items-center grid grid-cols-3"
      >
        <div class="justify-self-start">
          <input
            class="w-16 h-12 self-center bg-white text-gray-700
            border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none"
            v-if="input"
            id="grams"
            type="text"
            placeholder="Hay que arreglar el value"
            value=""
          >
          <span v-if="input">{{ parsedElements.measure }} </span>
        </div>
        <div :class="input ? '' : 'flex-auto m-1'">
          <span v-if="input">{{ parsedElements.name }}</span>
          <div v-if="!input">
            <span>{{ text }}</span>
          </div>
        </div>
        <div class="text-right">
          <button>
            <img
              class="w-4 h-4"
              v-if="svg.cancel"
              src="../../../../assets/images/cancel-svg.svg"
            >
          </button>
        </div>
      </div>
    </div>

    <div
      v-else
      :class="color ? 'bg-white' : 'bg-gray-100'"
    >
      <div class="p-4 flex items-center justify-items-center">
        <div class="justify-self-start flex-none m-2">
          <img
            v-if="svg.sixdots"
            svg-inline
            class="w-4 h-4 "
            src="../../../../assets/images/menu-recipe-svg.svg"
          >
        </div>
        <div class="flex-auto m-1">
          <span>{{ text }}</span>
        </div>
        <div class="flex-none text-right m-2">
          <button>
            <img
              class="w-4 h-4"
              v-if="svg.cancel"
              src="../../../../assets/images/cancel-svg.svg"
            >
          </button>
          <dropdown
            v-if="svg.dropdown"
            :elements="{
              edit:true,
              del:true
            }"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    text: { type: String, default: () => ('') },
    element: { type: Object, default: () => ({}) },
    input: { type: Boolean, required: true },
    svg: { type: Object, required: true },
    color: { type: Boolean, required: true },
  },
  computed: {
    parsedElements() {
      const parsedElements = JSON.parse(this.text);

      return parsedElements;
    },
  },
};
</script>
