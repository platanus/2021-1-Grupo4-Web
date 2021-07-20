<template>
  <div class="flex flex-col flex-start p-0 static w-auto h-auto">
    <div class="flex-none order-2 flex-grow-0">
      <recipes-item
        v-for="recipe in pageRecipes"
        :key="recipe.id"
        :recipe="recipe"
      />
      <base-pagination
        :current-page="currentPage"
        :final-page="finalPage"
        @next="nextPage"
        @prev="prevPage"
        @change-page="changePage"
      />
    </div>
  </div>
</template>

<script>
import RecipesItem from './recipes-item';

export default {
  components: {
    RecipesItem,
  },
  props: {
    allrecipes: { type: Array, required: true },
    pageSize: { type: Number, required: true },
    filter: { type: String, required: true },
  },
  data() {
    return {
      currentPage: 1,
    };
  },
  computed: {
    pageRecipes() {
      return this.allrecipes.slice(
        (this.currentPage - 1) * this.pageSize, Math.min(
          this.allrecipes.length, this.currentPage * this.pageSize));
    },
    finalPage() {
      return Math.ceil(this.allrecipes.length / this.pageSize);
    },
  },
  methods: {
    nextPage() {
      this.currentPage += 1;
    },
    prevPage() {
      this.currentPage -= 1;
    },
    changePage(index) {
      this.currentPage = index;
    },
  },
  watch: {
    allrecipes() {
      if (this.currentPage > this.finalPage) {
        this.currentPage = this.finalPage;
      } else if (this.currentPage <= 0) {
        this.currentPage = 1;
      }
    },
    filter() {
      this.currentPage = 1;
    },
  },
};
</script>
