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
          @click="openAddModal"
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
    openAddModal() {
      this.showingAdd = !this.showingAdd;
      this.recipesMenuToEdit = [];
    },
    closeAddModal() {
      this.showingAdd = !this.showingAdd;
      this.recipesMenuToEdit = [];
    },
    addMenu() {
      // prepare data and post menu
      console.log(this.$refs.addMenuInfo.selectedRecipes);
      console.log(this.$refs.addMenuInfo.menuName);
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
    editMenu() {
      // prepare data and save changes
      console.log(this.$refs.editMenuInfo.selectedRecipes);
      console.log(this.$refs.editMenuInfo.menuName);
      this.closeEditModal();
    },
  },
};
</script>
