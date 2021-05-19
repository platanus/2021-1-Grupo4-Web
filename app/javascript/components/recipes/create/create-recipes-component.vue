<template>
  <div>
    <!-- Title -->
    <div class="flex justify-between items-center w-auto h-8 self-stretch flex-grow-0 my-3">
      <div class="flex items-center">
        <a href="/recipes">
          <img
            class="h-6 w-6 text-white mx-2"
            svg-inline
            src="../../../../assets/images/arrow-left-svg.svg"
          >
        </a>
        <div class="h-7 font-sans font-normal text-2xl text-black flex-grow mx-2">
          {{ $t('msg.recipes.create') }}
        </div>
      </div>
    </div>

    <p class="text-xl">
      {{ $t('msg.recipes.basic') }}
    </p>

    <div class="grid grid-cols-4 gap-4">
      <input
        :placeholder="$t('msg.recipes.name')"
        :search-icon="false"
        class="col-span-2 w-full mx-1 my-4 p-2 border-2 rounded border-gray-300"
      >
      <input
        :placeholder="$t('msg.recipes.portions')"
        :search-icon="false"
        class="w-full mx-1 my-4 p-2 border-2 rounded border-gray-300"
      >
      <input
        :placeholder="$t('msg.recipes.preparation')"
        :search-icon="false"
        class="w-full mx-1 my-4 p-2 border-2 rounded border-gray-200 border-gray-300"
      >
    </div>

    <div class="grid grid-cols-3 gap-4">
      <div>
        <list
          :placeholder="$t('msg.recipes.ingredients')"
          :elements="getIngredients"
          :svg="{sixdots: false, cancel: true, menu_recipe: false, dropdown: false}"
          :input="true"
          :drag="false"
        />
      </div>
      <div
        id="steps"
        class="col-span-2"
      >
        <list
          :placeholder="$t('msg.recipes.steps')"
          :elements="getSteps"
          :svg="{sixdots: true, cancel: false, menu_recipe: true, dropdown: true}"
          :input="false"
          :drag="true"
        />
      </div>
    </div>
    <div class="grid grid-cols-6">
      <div />
      <div />
      <div />
      <div />
      <div />
      <base-button
        :elements="{
          placeholder: $t('msg.recipes.create'),
          color: 'bg-blue-600 text-white hover:bg-blue-400'
        }"
        @click="create"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    objects: { type: Array, required: true },
  },
  methods: {
    create() {
      return null;
    },
  },
  computed: {
    getSteps() {
      const steps = [this.objects[this.objects.length - 1]];
      const parsedSteps = JSON.parse(steps).instructions;
      const newSteps = parsedSteps.split('\n');

      return newSteps;
    },
    getIngredients() {
      const newArray = [];
      for (let i = 0; i < this.objects.length - 1; i++) {
        newArray.push(this.objects[i]);
      }

      return newArray;
    },
  },
  computed: {
    getSteps() {
      const steps = [this.objects[this.objects.length - 1]];
      const parsedSteps = JSON.parse(steps).instructions;
      const newSteps = parsedSteps.split('\n');

      return newSteps;
    },
    getIngredients() {
      const newArray = [];
      for (let i = 0; i < this.objects.length - 1; i++) {
        newArray.push(this.objects[i]);
      }

      return newArray;
    },
  },
};
</script>
