<template>
  <div
    class="relative"
    @mouseover="hover"
    @mouseleave="leave"
  >
    <div
      :class="(isHover) ? 'flex justify-center h-48 w-48 opacity-30' : 'flex justify-center h-48 w-48'"
    >
      <img
        class="object-contain"
        :src="imgUrl"
      >
    </div>
    <div class="text-sm font-bold">
      {{ name }}
    </div>
    <div class="text-sm font-semibold text-yellow-600">
      {{ `$ ${price}` }}
    </div>
    <div class="text-sm font-light text-gray-800">
      {{ packageDescription }}
    </div>

    <div
      v-if="isHover"
      class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 z-4"
    >
      <base-button
        :elements="{
          placeholder: $t('msg.ingredients.searchAdd'),
          color: 'bg-yellow-500 hover:bg-yellow-700 text-white'
        }"
        @click="addMarketIngredient"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    imgUrl: { type: String, required: true },
    name: { type: String, required: true },
    price: { type: Number, required: true },
    packageDescription: { type: String, required: true },
  },
  data() {
    return {
      isHover: false,
    };
  },
  methods: {
    hover() {
      this.isHover = true;
    },
    leave() {
      this.isHover = false;
    },
    addMarketIngredient() {
      this.$emit('submit');
    },
  },
};

</script>
