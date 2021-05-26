<template>
  <p
    class="content-center font-semibold text-left"
  >
    {{ recipesQuantity }}
  </p>
</template>

<script>
export default {
  props: {
    menu: { type: Object, required: true },
  },

  computed: {
    recipesQuantity() {
      return this.menu.menuRecipes.data.length;
    },
  },

};
</script>
