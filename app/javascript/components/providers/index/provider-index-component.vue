<template>
  <!-- <div>
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
      />
    </base-modal>

    <base-modal
      @ok="editProvider"
      @cancel="toggleEditModal"
      v-if="showingEdit"
      :title="$t('msg.providers.edit')"
      :ok-button-label="$t('msg.save')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <providers-form
        ref="editProviderInfo"
        :provider="this.providerToEdit"
      />
    </base-modal>
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
   -->
  <div>
    <div class="flex justify-between items-center h-8">
      <div class="w-auto h-7 font-sans font-normal text-2xl text-black flex-none flex-grow-0">
        {{ $t('msg.providers.title') }}
      </div>
      <button
        class="flex justify-center items-center align-center px-3 w-auto h-8 text-white rounded flex-none flex-grow-0 bg-blue-700"
        @click="toggleAddModal"
      >
        Agregar Proveedor
      </button>
    </div>

    <div
      class="flex items-start flex-col w-full"
      v-for="element in this.providers"
      :key="element.id"
    >
      <div class="flex flex-row items-start flex-none flex-grow-0 order-none w-5/12">
        <provider-item
          :provider="element"
          @update="updateProvider"
          @del="deleteProvider"
        />
      </div>
    </div>

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
      />
    </base-modal>
  </div>
</template>

<script>
import { getProviders, postProvider } from './../../../api/providers.js';
import ProviderItem from './provider-item';
import ProvidersForm from './providers-form';

export default {
  data() {
    return {
      showingDel: false,
      showingAdd: false,
      showingEdit: false,
      providers: [],
      providerToDelete: {},
      providerToEdit: {},
      tableHeader: ['name', 'address', 'country'],
    };
  },
  components: {
    ProviderItem,
    ProvidersForm,
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
      this.showingEdit = !this.showingEdit;
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
        console.log(attributes);
        const providerToAdd = { id, ...attributes };
        this.providers.push(providerToAdd);
        this.successResponse(status);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async updateProvider(res, providerId) {
      this.showingEdit = !this.showingEdit;
      console.log('A', res.config.data);
      const providerEdited = { id: providerId, ...JSON.parse(res.config.data).provider };
      const objectIndex = this.providers.findIndex((obj => obj.id === providerId));
      this.providers.splice(objectIndex, 1);
      this.providers.splice(objectIndex, 0, providerEdited);
      console.log('A', this.providers);
    },

    async deleteProvider(id, response) {
      this.showingDel = !this.showingDel;
      try {
        // const response = await deleteProvider(id);
        this.providers = this.providers.filter(item => item.id !== id);
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
  },
};

</script>
