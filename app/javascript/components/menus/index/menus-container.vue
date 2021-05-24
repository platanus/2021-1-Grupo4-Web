<template>
  <div class="flex flex-col">
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.title') }}
      </div>
    </div>
    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <div class="flex items-center pb-6">
        <menus-search-bar :placeholder="$t('msg.menus.search')" />
        <base-button
          :elements="{ placeholder: $t('msg.menus.add'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
          @click="redirectAddMenu"
        />
      </div>
      <div class="flex items-center">
        <p
          v-if="this.menus.length===0"
        >
          {{ $t('msg.noElements') }} {{ $t('msg.menus.title') }}
        </p>
        <menus-table
          v-else
          :menus="menus"
          @edit="openEditModal"
          @del="toggleDelModal"
        />
      </div>
    </div>

    <!--DeleteModal-->
    <base-modal
      @ok="deleteMenu"
      @cancel="toggleDelModal"
      v-if="showingDel"
      :title="$t('msg.menus.delete')"
      :ok-button-label="$t('msg.yesDelete')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <p>{{ $t('msg.menus.deleteMsg') }}</p>
    </base-modal>

    <!--EditModal-->
    <base-modal
      @ok="editMenu"
      @cancel="closeEditModal"
      v-if="showingEdit"
      :title="$t('msg.menus.edit')"
      :ok-button-label="$t('msg.save')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <!-- Search Bar -->
      <div class="flex items-center mx-6">
        <menu-recipes-search-bar
          :placeholder="$t('msg.menus.searchRecipes')"
        />
      </div>
      <!-- Body -->
      <div class="flex items-start  mx-6">
        <p
          v-if="menus.length===0"
        >
          {{ $t('msg.noResults') }}
        </p>
        <search-results
          :recipes-result="searchedRecipes"
          :menu-to-edit="menuToEdit"
          @pushRecipe="pushRecipe"
          @removeRecipe="removeRecipe"
        />
        <selected-recipes
          :selected-recipes="selectedRecipes"
          :menu-to-edit="menuToEdit"
        />
      </div>
    </base-modal>
  </div>
</template>

<script>
import { getMenus, deleteMenu } from './../../../api/menus.js';
import { getRecipes } from './../../../api/recipes.js';
import MenusSearchBar from './menus-search-bar.vue';
import MenusTable from './menus-table.vue';
import MenuRecipesSearchBar from '../edit/menu-recipes-search-bar';
import SearchResults from '../edit/search-results';
import SelectedRecipes from '../edit/selected-recipes';

export default {
  components: {
    MenusSearchBar,
    MenusTable,
    MenuRecipesSearchBar,
    SearchResults,
    SelectedRecipes,
  },
  data() {
    return {
      showingEdit: false,
      showingDel: false,
      menus: [],
      menuToEdit: { 'menuRecipes': { 'data': [] } },
      menuToDelete: {},
      searchedRecipes: [],
      error: '',
    };
  },
  async created() {
    try {
      const response = await getMenus();
      this.menus = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    }
    try {
      const response = await getRecipes();
      this.searchedRecipes = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    }
  },
  methods: {
    // Delete methods
    toggleDelModal(menu) {
      this.showingDel = !this.showingDel;
      this.menuToDelete = menu;
    },
    async deleteMenu() {
      this.showingDel = !this.showingDel;
      try {
        await deleteMenu(this.menuToDelete.id);
        this.menus = this.menus.filter(item => item.id !== this.menuToDelete.id);
        this.error = '';
      } catch (error) {
        this.error = error;
      }
    },
    // Add methods
    redirectAddMenu() {
      window.location.href = '/menus/new';
    },
    // Edit methods
    openEditModal(menu) {
      this.showingEdit = !this.showingEdit;
      this.menuToEdit = menu;
      this.selectedRecipes = [... this.menuToEdit.menuRecipes.data];
    },
    closeEditModal() {
      this.showingEdit = !this.showingEdit;
      this.selectedRecipes = [];
    },
    pushRecipe(menuRecipe) {
      this.selectedRecipes.push(menuRecipe);
    },
    removeRecipe(recipe) {
      const parsedId = parseInt(recipe.id, 10);
      const indexToRemove = this.selectedRecipes.findIndex((element) =>
        parseInt(element.attributes.recipe.id, 10) === parsedId);
      this.selectedRecipes.splice(indexToRemove, 1);
    },
    editMenu() {
      // save changes
      this.closeEditModal();
    },
  },
};
</script>
