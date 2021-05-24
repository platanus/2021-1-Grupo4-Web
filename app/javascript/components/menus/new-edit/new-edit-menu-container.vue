<template>
  <div>
    <!-- Menu Name -->
    <div class="flex items-center mx-6">
      <input
        class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
        id="menu-name"
        type="text"
        :placeholder="$t('msg.menus.name')"
        v-model="menuName"
      >
    </div>
    <!-- Search Bar -->
    <div class="flex items-center mx-6">
      <menu-recipes-search-bar
        :placeholder="$t('msg.menus.searchRecipes')"
      />
    </div>
    <!-- Body -->
    <div class="flex items-start  mx-6">
      <search-results
        :recipes-result="searchedRecipes"
        :recipes-menu-to-edit="recipesMenuToEdit"
        @pushRecipe="pushRecipe"
        @removeRecipe="removeRecipe"
      />
      <selected-recipes
        :selected-recipes="selectedRecipes"
        :menu-to-edit="menuToEdit"
      />
    </div>
  </div>
</template>

<script>
import MenuRecipesSearchBar from './menu-recipes-search-bar';
import SearchResults from './search-results';
import SelectedRecipes from './selected-recipes';

export default {
  components: {
    MenuRecipesSearchBar,
    SearchResults,
    SelectedRecipes,
  },

  props: {
    editMode: { type: Boolean, required: true },
    menuToEdit: { type: Object, default() {
      return {};
    } },
    searchedRecipes: { type: Array, required: true },
    recipesMenuToEdit: { type: Array, required: true },
  },

  data() {
    return {
      selectedRecipes: [...this.recipesMenuToEdit],
      menuName: '',
    };
  },

  created() {
    if (this.editMode) {
      this.menuName = this.menuToEdit.name;
    } else {

    }
  },

  methods: {
    pushRecipe(menuRecipe) {
      this.selectedRecipes.push(menuRecipe);
    },
    removeRecipe(recipe) {
      const parsedId = parseInt(recipe.id, 10);
      const indexToRemove = this.selectedRecipes.findIndex((element) =>
        parseInt(element.attributes.recipe.id, 10) === parsedId);
      this.selectedRecipes.splice(indexToRemove, 1);
    },
  },
};
</script>
