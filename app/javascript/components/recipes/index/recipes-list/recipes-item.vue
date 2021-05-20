<template>
  <div class="flex flex-row justify-between items-center p-6 static h-24 bg-white border-2 border-solid border-gray-400 box-border my-2 flex-none flex-grow-0 self-stretch m-0">
    <recipes-item-info
      :recipe-name="name"
      :recipe-portions="portions"
      :recipe-minutes="minutes"
    />
    <recipes-item-price :recipe-price="price" />
  </div>
</template>

<script>
import RecipesItemInfo from './recipes-item-info';
import RecipesItemPrice from './recipes-item-price';

export default {

  components: {
    RecipesItemInfo,
    RecipesItemPrice,
  },

  props: {
    name: { type: String, required: true },
    portions: { type: Number, required: true },
    minutes: { type: Number, required: true },
    price: { type: Number, required: true },
  },
};
</script>
