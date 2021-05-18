<template>
  <div class="flex flex-row justify-between items-center p-6 static h-24 bg-white border-2 border-solid border-gray-400 box-border my-2 flex-none flex-grow-0 self-stretch m-0">
    <info-recipe
      :recipe-name="recipe.name"
      :recipe-portions="recipe.portions"
      :recipe-minutes="recipe.cookMinutes"
    />
    <price-recipe
      :id-recipe="recipe.id"
      :recipe-price="recipePrice"
    />
  </div>
</template>

<script>
export default {
  props: {
    recipe: { type: Object, required: true },
  },
  methods: {
    ingredientFinalPrice(quantity, price) {
      return (quantity * price);
    },
  },
  computed: {
    recipePrice() {
      return this.recipe.ingredients.map(element =>
        this.ingredientFinalPrice(element.quantity, element.price)).reduce((acc, curVal) => acc + curVal, 0);
    },
  },
};
</script>
