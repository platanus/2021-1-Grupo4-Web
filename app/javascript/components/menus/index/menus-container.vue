<template>
  <div class="flex flex-col">
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.title') }}
      </div>
    </div>
    <div class="flex flex-col p-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <search-bar-menus :placeholder="$t('msg.menus.search')" />
      <main-table-menus
        :dots="true"
        :header="tableHeader"
        :body="menus"
        model-type="menus"
        @edit="toggleEditModal"
        @del="toggleDelModal"
      />
    </div>
  </div>
</template>

<script>
import MainTableMenus from './main-table-menus';
import SearchBarMenus from './search-bar-menus';

export default {
  props: {
    menus: { type: Array, required: true },
  },
  components: {
    SearchBarMenus,
    MainTableMenus,
  },
  data() {
    return {
      showingEdit: false,
      showingDel: false,
      tableHeader: ['name', 'totalPrice', 'recipesQuantity', 'recipes'],
    };
  },

  methods: {
    toggleEditModal() {
      this.showingEdit = !this.showingEdit;
    },
    toggleDelModal() {
      this.showingDel = !this.showingDel;
    },
  },
};
</script>
