<template>
  <div>
    <div class="flex justify-between items-center h-8 mb-5">
      <div class="w-auto h-7 font-sans font-normal text-2xl text-black flex-none flex-grow-0">
        {{ $t('msg.providers.title') }}
      </div>
      <div class="px-2">
        <base-button
          :elements="{ placeholder: $t('msg.providers.add'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
          @click="toggleAddModal"
        />
      </div>
    </div>

    <div class="flex flex-col sm:flex-row flex-wrap justify-between w-full">
      <div
        class="flex items-start w-6/12"
        v-for="element in this.providers"
        :key="element.id"
      >
        <div class="flex flex-row items-start flex-none flex-grow-0 order-none w-full">
          <provider-item
            :provider="element"
            @update="updateProvider"
            @del="deleteProvider"
          />
        </div>
      </div>
    </div>

    <providers-form
      @add-provider="addProvider"
      @toggle-add-modal="toggleAddModal"
      v-if="showingAdd"
      :title="$t('msg.providers.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
      :showing-add="showingAdd"
    />
  </div>
</template>

<script>
import camelcase from 'camelcase';
import { getProviders, postProvider } from './../../../api/providers.js';
import ProviderItem from './provider-item';
import ProvidersForm from './providers-form';

export default {
  data() {
    return {
      showingAdd: false,
      providers: [],
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

    async addProvider(provider) {
      try {
        const {
          status,
          data:
            { data: { id, attributes },
            },
        } = await postProvider(provider);
        this.toggleAddModal();
        const providerToAdd = { id, ...attributes };
        this.providers.push(providerToAdd);
        this.successResponse(status);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    changeKeys(attributes) {
      const newKeys = {};
      const entries = Object.entries(attributes);
      for (let i = 0; i < entries.length; i++) {
        newKeys[camelcase(entries[i][0])] = entries[i][1];
      }

      return newKeys;
    },

    async updateProvider(res, providerId) {
      const attributes = JSON.parse(res.config.data).provider;
      const newAttributes = this.changeKeys(attributes);
      const providerEdited = { id: providerId, ...newAttributes };
      const objectIndex = this.providers.findIndex((obj => obj.id === providerId));
      this.providers.splice(objectIndex, 1);
      this.providers.splice(objectIndex, 0, providerEdited);
    },

    async deleteProvider(id, response) {
      try {
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
