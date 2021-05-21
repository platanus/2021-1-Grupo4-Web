<template>
  <div class="flex flex-col">
    <div class="flex items-center h-8 order-0 flex-grow-0 mt-1">
      <div class="text-4xl order-0 flex-grow-0">
        {{ $t('msg.menus.title') }}
      </div>
    </div>
    <div class="flex flex-col p-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
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
          :dots="true"
          :header="tableHeader"
          :body="menus"
          model-type="menus"
          @edit="toggleEditModal"
          @del="toggleDelModal"
        />
      </div>
    </div>
  </div>
</template>

<script>
import MenusSearchBar from './menus-search-bar.vue';
import MenusTable from './menus-table.vue';

export default {
  props: {
    menus: { type: Array, required: true },
  },
  components: {
    MenusSearchBar,
    MenusTable,
  },
  data() {
    return {
      showingEdit: false,
      showingDel: false,
      tableHeader: ['name', 'totalPrice', 'recipesQuantity', 'recipes'],
    };
  },

  methods: {
    redirectAddMenu() {
      window.location.href = '/menus/new';
    },
    toggleEditModal() {
      this.showingEdit = !this.showingEdit;
    },
    toggleDelModal() {
      this.showingDel = !this.showingDel;
    },
  },
};
</script>
