<template>
  <div class="flex flex-col">
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.title') }}
      </div>
    </div>
    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <div class="flex items-center pb-6">
        <div class="relative text-yellow-700">
          <span class="absolute inset-y-0 left-0 flex items-center pl-3">
            <img
              svg-inline
              src="../../../../assets/images/magnifyng-glass-svg.svg"
              class="w-6 h-6 text-yellow-700"
            >
          </span>
          <input
            class="flex py-2 px-12 w-96 h-16 bg-gray-50 border-2 border-gray-600 rounded self-stretch flex-grow-0 focus:outline-none"
            :placeholder="$t('msg.menus.search')"
            autocomplete="off"
            @keyup="filterMenus"
            v-model="searchQuery"
          >
        </div>
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
          :menus="filterMenus()"
          @edit="toggleEditModal"
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
  </div>
</template>

<script>
import { getMenus, deleteMenu } from './../../../api/menus.js';
// import MenusSearchBar from './menus-search-bar.vue';
import MenusTable from './menus-table.vue';

export default {
  components: {
    // MenusSearchBar,
    MenusTable,
  },
  data() {
    return {
      showingEdit: false,
      showingDel: false,
      menus: [],
      searchQuery: null,
      menuToDelete: {},
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
  },
  methods: {
    redirectAddMenu() {
      window.location.href = '/menus/new';
    },
    toggleEditModal() {
      this.showingEdit = !this.showingEdit;
    },
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
    filterMenus() {
      if (this.searchQuery) {
        return this.menus.filter(item => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.menus;
    },
  },
};
</script>
