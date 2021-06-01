<template>
  <div class="flex w-80 flex-col">
    <span class="flex content-center justify-center">{{ $t('msg.ingredients.selected') }}</span>
    <div
      class="flex p-4 grid grid-cols-2 items-center justify-between "
      v-for="(element, index) in elements"
      :key="index"
      :class="index % 2 === 1 ? 'bg-white' : 'bg-gray-100'"
    >
      <span class="flex content-center justify-center">
        {{ element.name }}
      </span>
      <button
        @click="deleteIngredient(index)"
      >
        <img
          class="w-4 h-4"
          src="../../../../assets/images/cancel-svg.svg"
        >
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Array, required: true },
    svg: { type: Object, required: true },
    placeholder: { type: String, required: true },
    input: { type: Boolean, required: true },
  },
  methods: {
    search() {
      return null;
    },
    deleteIngredient(index) {
      this.$emit('delete-ingredient', index);
    },
  },
};
</script>
