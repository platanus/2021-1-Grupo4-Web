<template>
  <div>
    <h2 class="text-4xl">
      {{ $t('msg.providers.title') }}
    </h2>
    <div class="flex items-center">
        <providers-search-bar
        kind="provider"
        :placeholder="$t('msg.providers.search')"
        />
      <base-button
        :elements="{ placeholder: $t('msg.providers.add'),
                     color: 'bg-green-500 hover:bg-green-700 text-white' }"
        @click="toggleAddModal"
      />
    </div>
    <div>
      <p
        v-if="this.providers.length===0"
      >
        {{ $t('msg.noElements') }} {{ $t('msg.providers.title') }}
      </p>
      <base-table
        v-else
        :dots="true"
        :header="tableHeader"
        :body="this.providers"
        model-type="providers"
        @edit="toggleEditModal"
        @del="toggleDelModal"
      />
    </div>

    <!--AddModal-->
    <base-modal
      @ok="addProvider"
      @cancel="toggleAddModal"
      v-if="showingAdd"
      :title="$t('msg.providers.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <providers-form
        ref="addProviderInfo"
        :edit-mode="false"
      />
    </base-modal>
    
    <!--DeleteModal-->
    <base-modal
      @ok="deleteProvider"
      @cancel="toggleDelModal"
      v-if="showingDel"
      :title="$t('msg.providers.delete')"
      :ok-button-label="$t('msg.yesDelete')"
      :cancel-button-label="$t('msg.cancel')">
      <p>{{ $t('msg.providers.deleteMsg') }}</p>
    </base-modal>
    
  </div>
  
</template>

<script>
import { getProviders, postProvider, deleteProvider } from './../../api/providers.js';
import ProvidersSearchBar from './providers-search-bar';
import ProvidersForm from './providers-form';

export default {
  data() {
    return {
      showingDel: false,
      showingAdd: false,
      providers: [],
      providerToDelete: {},
      providerToEdit: {},
      tableHeader: ['name', 'address', 'country'],
    }
  },
  components: {
    ProvidersSearchBar,
    ProvidersForm
  },

  async created() {
    try {
      const response = await getProviders();
      this.providers = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.successResponse(response);
    } catch (error) {
      this.errorResponse(error);
    }
  },
  methods: {
    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
    },
    toggleDelModal(provider) {
      this.showingDel = !this.showingDel;
      this.providerToDelete = provider;
    },
    toggleEditModal(provider) {
      //this.showingEdit = !this.showingEdit;
      this.providerToEdit = provider;
    },

    async addProvider() {
      this.showingAdd = !this.showingAdd;
      try {
        const {
          status,
          data:
            { data: { id, attributes },
            },
        } = await postProvider(this.$refs.addProviderInfo.form);
        const providerToAdd = { id, ...attributes };
        this.providers.push(providerToAdd);
        this.successResponse(status);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async deleteProvider() {
      this.showingDel = !this.showingDel;
      try {
        const response = await deleteProvider(this.providerToDelete.id);
        this.providers = this.providers.filter(item => item.id !== this.providerToDelete.id);
        this.successResponse(response);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async successResponse(status) {
      this.status = status;
      this.error = '';
    },
    async errorResponse(error) {
      this.status = error.response.status;
      this.error = error;
    },
  }
};

</script>
