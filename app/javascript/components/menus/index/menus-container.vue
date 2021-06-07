<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.title') }}
      </div>
    </div>
    <!-- Content bg-white -->
    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <!-- Search bar and Add button -->
      <div class="flex items-center pb-6">
        <menus-search-bar :placeholder="$t('msg.menus.search')" />
        <base-button
          :elements="{ placeholder: $t('msg.menus.add'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
          @click="openAddModal"
        />
      </div>
      <!-- Table -->
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
      <new-edit-menu-container
        ref="editMenuInfo"
        :edit-mode="true"
        :menu-to-edit="menuToEdit"
        :searched-recipes="searchedRecipes"
        :recipes-menu-to-edit="recipesMenuToEdit"
      />
    </base-modal>

    <!--AddModal-->
    <base-modal
      @ok="addMenu"
      @cancel="closeAddModal"
      v-if="showingAdd"
      :title="$t('msg.menus.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <new-edit-menu-container
        ref="addMenuInfo"
        :edit-mode="false"
        :searched-recipes="searchedRecipes"
        :recipes-menu-to-edit="recipesMenuToEdit"
      />
    </base-modal>
  </div>
</template>

<script>
import { getMenus, deleteMenu, postMenu, editMenu } from './../../../api/menus.js';
import { getRecipes } from './../../../api/recipes.js';
import MenusSearchBar from './menus-search-bar.vue';
import MenusTable from './menus-table.vue';
import NewEditMenuContainer from '../new-edit/new-edit-menu-container';

export default {
  components: {
    MenusSearchBar,
    MenusTable,
    NewEditMenuContainer,
  },

  data() {
    return {
      showingEdit: false,
      showingDel: false,
      showingAdd: false,
      menus: [],
      menuToEdit: { 'menuRecipes': { 'data': [] } },
      menuToDelete: {},
      searchedRecipes: [],
      error: '',
      recipesMenuToEdit: [],
    };
  },

  created() {
    this.getAllMenus();
    this.getAllRecipes();
  },

  methods: {
    // Get menus
    async getAllMenus() {
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
    },
    // Get recipes
    async getAllRecipes() {
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
    openAddModal() {
      this.showingAdd = !this.showingAdd;
      this.recipesMenuToEdit = [];
    },
    closeAddModal() {
      this.showingAdd = !this.showingAdd;
      this.recipesMenuToEdit = [];
    },
    prepareRecipesInfo(recipes) {
      const recipesInfo = [];
      for (const recipe of recipes) {
        const recipeInfo = {};
        recipeInfo.recipeId = parseInt(recipe.attributes.recipe.id, 10);
        recipeInfo.recipeQuantity = recipe.attributes.recipeQuantity;
        recipesInfo.push(recipeInfo);
      }

      return recipesInfo;
    },
    async addMenu() {
      const recipesInfo = this.prepareRecipesInfo(this.$refs.addMenuInfo.selectedRecipes);
      const menuToPost = { name: this.$refs.addMenuInfo.menuName, menuRecipesAttributes: recipesInfo };
      try {
        const {
          data:
            { data: { id, attributes },
            },
        } = await postMenu(menuToPost);
        this.menus.push({ id, ...attributes });
        this.error = '';
      } catch (error) {
        this.error = error;
      }
      this.closeAddModal();
    },
    // Edit methods
    openEditModal(menu) {
      this.showingEdit = !this.showingEdit;
      this.menuToEdit = menu;
      this.recipesMenuToEdit = [... this.menuToEdit.menuRecipes.data];
    },
    closeEditModal() {
      this.showingEdit = !this.showingEdit;
      this.recipesMenuToEdit = [];
    },
    async editMenu() {
      const recipesInfo = this.prepareRecipesInfo(this.$refs.editMenuInfo.selectedRecipes);
      const menuToPut = { name: this.$refs.editMenuInfo.menuName, menuRecipesAttributes: recipesInfo };
      // console.log(menuToPut);
      // try {
      //   const res = await editMenu(this.menuToEdit.id, menuToPut);
      //   console.log(res);
      //   this.getAllMenus();
      //   this.error = '';
      // } catch (error) {
      //   this.error = error;
      // }
      this.closeEditModal();
    },
  },
};
</script>
