<template>
  <div class="flex items-start justify-between w-full h-20 border border-gray-500 bg-gray-50 flex-none">
    <!-- Image -->
    <img
      svg-inline
      src="../../../../assets/images/recipe.jpg"
      class="w-20 h-20 text-yellow-700"
    >
    <!-- Name and info -->
    <div class="flex flex-col items-start w-full h-16 mx-3 my-auto">
      <p class="py-2 px-3 font-medium">
        {{ name }}
      </p>
      <div>
        <p class="py-2 px-3 text-xs inline-block">
          {{ portions }} {{ $t('msg.recipes.portions') }}
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          {{ recipePrice | currency }}
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          {{ minutes }} {{ $t('msg.recipes.minutes') }}
        </p>
      </div>
    </div>
    <!-- button -->
    <button
      class="flex items-center py-1.5 px-4 w-auto h-9 bg-yellow-500 shadow-sm rounded-md flex-none my-auto mx-3"
      @click="addRecipe()"
    >
      <div class="w-auto h-6 font-hind font-normal text-base text-white flex-none">
        {{ $t('msg.add') }}
      </div>
    </button>
  </div>
</template>

<script>

export default {
  props: {
    name: { type: String, required: true },
    portions: { type: Number, required: true },
    minutes: { type: Number, required: true },
    recipeIngredients: { type: Array, required: true },
  },
  methods: {
    addRecipe() {
      this.$emit('add');
    },
    getPriceOfSelectedIngredient(recipeIngredient) {
      if (!recipeIngredient.ingredientQuantity) return 0;

      return recipeIngredient.ingredientQuantity *
      recipeIngredient.ingredient.price / recipeIngredient.ingredient.quantity;
    },
  },
  computed: {
    recipePrice() {
      return this.recipeIngredients.reduce((recipePrice, recipeIngredient) =>
        recipePrice + this.getPriceOfSelectedIngredient(recipeIngredient.attributes), 0);
    },
  },
};
</script>
