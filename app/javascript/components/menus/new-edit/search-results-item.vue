<template>
  <div
    class="flex items-center pr-4"
    :class="selected ? 'bg-gray-200' : ''"
  >
    <!-- Image -->
    <img
      svg-inline
      src="../../../../assets/images/recipe.jpg"
      class="w-20 h-20 text-yellow-700"
    >
    <!-- Name and info -->
    <div class="mr-20">
      <p class="py-2 px-3 font-medium">
        {{ recipe.name }}
      </p>
      <div>
        <p class="py-2 px-3 text-xs inline-block">
          {{ recipe.portions }} {{ $t('msg.recipes.portions') }}
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          $XX.XXX CLP
        </p>
        <p class="py-2 px-3 text-xs inline-block">
          {{ recipe.cookMinutes }} {{ $t('msg.recipes.minutes') }}
        </p>
      </div>
    </div>
    <!-- Checkbox -->
    <div class="">
      <input
        type="checkbox"
        class="form-checkbox h-5 w-5 text-yellow-500"
        v-model="selected"
        @click="updateSelected"
      >
    </div>
  </div>
</template>

<script>
export default {
  props: {
    recipe: { type: Object, required: true },
    recipesOfMenu: { type: Array, required: true },
  },

  data() {
    return {
      selected: false,
    };
  },

  created() {
    const recipesIds = this.recipesOfMenu.map((element) => element.attributes.recipe.id);
    this.selected = recipesIds.includes(parseInt(this.recipe.id, 10));
  },

  methods: {
    updateSelected() {
      if (this.selected) {
        this.$emit('remove', this.recipe);
      } else {
        this.$emit('push', this.recipe);
      }
    },
  },

};
</script>
