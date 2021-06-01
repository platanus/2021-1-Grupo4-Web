<template>
  <div class="flex flex-row justify-start items-center p-0 static w-min-content h-12 flex-none order-1 flex-grow-0 mt-6">
    <input
      class="flex flex-row static w-96 h-12 mr-2.5 bg-white border-2 border-solid border-gray-400 border-box box-border rounded text-sm flex-none order-0 flex-grow-1 pl-4"
      :placeholder="placeholder"
      autocomplete="off"
      v-model="searchQuery"
      @keyup.enter="filterRecipes"
    >
    <button
      class="flex flex-row items-center justify-center px-3 py-3 static w-auto h-8 bg-white border-2 border-solid
      border-blue-700 box-border rounded-full flex-none order-1 flex-grow-0 mx-2.5 text-blue-700"
      @click="filterByPrice()"
    >
      {{ $t('msg.recipes.price') }}
    </button>
    <button
      class="flex flex-row items-center justify-center px-3 py-3 static w-auto h-8 border-2 border-solid
      border-blue-700 box-border rounded-full flex-none order-2 flex-grow-0 mx-2.5 bg-blue-700 text-white"
      @click="filterByPortions()"
    >
      {{ $t('msg.recipes.portions') }}
    </button>
  </div>
</template>

<script>
export default {
  props: {
    placeholder: { type: String, required: true },
    recipes: { type: Array, required: true },
  },
  data() {
    return {
      searchQuery: '',
    };
  },
  methods: {
    filterByPrice() {
      this.$emit('filterByPrice');
    },
    filterByPortions() {
      this.$emit('filterByPortions');
    },
    filterRecipes() {
      if (this.searchQuery) {
        return this.$root.recipes.filter(item => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.$root.recipes;
    },
  },
};
</script>
