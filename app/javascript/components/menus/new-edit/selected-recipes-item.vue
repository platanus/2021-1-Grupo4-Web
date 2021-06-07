<template>
  <div class="flex items-center pr-4">
    <img
      svg-inline
      src="../../../../assets/images/recipe.jpg"
      class="w-20 h-20 text-yellow-700"
    >
    <div>
      <p class="py-2 px-3 font-medium">
        {{ recipe.attributes.recipe.name }}
      </p>
      <div class="mr-10">
        <p class="py-2 px-3 text-xs inline-block">
          {{ recipe.attributes.recipe.portions }} {{ $t('msg.recipes.portions') }}
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          $XX.XXX CLP
        </p>
        <img
          svg-inline
          src="../../../../assets/images/minus-svg.svg"
          class="h-5 w-5 inline-block cursor-pointer"
          @click="subtract"
        >
        <input
          class="inline block shadow hover:bg-none appearance-none border rounded w-12 h-5 text-gray-700 text-xs leading-tight focus:border-gray-600 focus:border-opacity-70 focus:ring focus:ring-gray-100 focus:ring-opacity-50"
          :id="`quantity${menu.id}-${recipe.id}`"
          type="text"
          v-model="quantity"
        >
        <img
          svg-inline
          src="../../../../assets/images/plus-svg.svg"
          class="h-5 w-5 inline-block cursor-pointer"
          @click="add"
        >
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipe: { type: Object, required: true },
    menu: { type: Object, required: true },
  },
  data() {
    return {
      quantity: this.recipe.attributes.recipeQuantity,
    };
  },

  methods: {
    subtract() {
      this.quantity -= 1;
    },
    add() {
      this.quantity += 1;
    },
  },

  watch: {
    quantity() {
      const recipeQuantityObjetc = { quantity: this.quantity, recipe: this.recipe };
      this.$emit('changeQuantity', recipeQuantityObjetc);
    },
  },

};
</script>
