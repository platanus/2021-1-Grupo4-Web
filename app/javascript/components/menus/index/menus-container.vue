<template>
  <div class="flex flex-col">
    <!-- Title -->
    <div class="flex items-center">
      <div class="text-4xl font-bold">
        {{ $t('msg.menus.title') }}
      </div>
      <span
        v-if="loading"
        class="flex my-auto w-8 h-8 ml-2 pl-2"
      >
        <base-spinner />
      </span>
    </div>

    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <!-- Search Bar and Add Button -->
      <div class="flex items-center pb-6">
        <div class="flex items-center py-2 pr-2 lg:w-1/2">
          <div class="relative text-yellow-700 w-full">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
              <img
                svg-inline
                src="../../../../assets/images/magnifyng-glass-svg.svg"
                class="w-6 h-6 text-yellow-700"
              >
            </span>
            <input
              class="w-full py-2 pl-12 bg-gray-50 border-2 border-gray-600 rounded self-stretch focus:outline-none z-200"
              :placeholder="$t('msg.menus.search')"
              autocomplete="off"
              v-model="searchQuery"
            >
          </div>
        </div>
        <div class="flex justify-end w-full">
          <a
            class="my-2 h-10 font-bold py-2 px-6 rounded shadow-md flex-shrink-0 bg-green-500 hover:bg-green-700 text-white"
            href="/menus/new"
          >
            {{ $t('msg.menus.add') }}
          </a>
        </div>
      </div>
      <!-- Content -->
      <div v-if="!loading">
        <p
          class="my-4"
          v-if="this.menus.length===0"
        >
          {{ $t('msg.noElements') }} {{ $t('msg.menus.title').toLowerCase() }}
        </p>
        <div
          v-else
          class="flex w-full 2xl:justify-center items-center"
        >
          <menus-table
            :menus="filteredMenus"
            @del="toggleDelModal"
          />
        </div>
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
import MenusTable from './menus-table.vue';

export default {
  components: {
    MenusTable,
  },
  data() {
    return {
      loading: false,
      showingEdit: false,
      showingDel: false,
      menus: [],
      searchQuery: null,
      menuToDelete: {},
    };
  },
  async created() {
    this.loading = true;
    try {
      const response = await getMenus();
      this.menus = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.error = '';
    } catch (error) {
      this.error = error;
    } finally {
      this.loading = false;
    }
  },
  computed: {
    filteredMenus() {
      if (this.searchQuery) {
        return this.menus.filter(item => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => item.name.toLowerCase().includes(text)));
      }

      return this.menus;
    },
  },
  methods: {
    toggleDelModal(menu) {
      this.showingDel = !this.showingDel;
      this.menuToDelete = menu;
    },
    async deleteMenu() {
      this.showingDel = !this.showingDel;
      this.loading = true;
      try {
        await deleteMenu(this.menuToDelete.id);
        this.menus = this.menus.filter(item => item.id !== this.menuToDelete.id);
        this.error = '';
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>
