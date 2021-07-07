<template>
  <div class="flex flex-col">
    <!-- title -->
    <div class="flex items-center">
      <div class="font-bold text-4xl">
        {{ $t('msg.providers.title') }}
      </div>
      <span
        v-if="loading"
        class="flex w-8 h-8 my-auto pl-2 ml-2"
      >
        <base-spinner />
      </span>
    </div>
    <!-- info -->
    <div class="flex flex-col pt-6 pb-10 px-10 w-auto h-auto bg-gray-50 flex-grow-0 my-10">
      <!-- searchBar y button -->
      <div class="flex flex-col lg:flex-row pb-6">
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
              :placeholder="$t('msg.providers.search')"
              @keyup="filterProviders"
              v-model="searchQuery"
            >
          </div>
        </div>
        <div class="flex justify-end w-full">
          <a
            class="my-2 h-10 font-bold py-2 px-6 rounded shadow-md flex-shrink-0 bg-green-500 hover:bg-green-700 text-white cursor-pointer"
            @click="toggleAddModal"
          >
            {{ $t('msg.providers.add') }}
          </a>
        </div>
      </div>
      <!-- proovedores -->
      <div
        class="flex w-full flex-wrap justify-between bg-gray-50"
      >
        <p
          v-if="this.providers.length===0 && !loading"
          class="p-2"
        >
          {{ $t('msg.noElements') }} {{ $t('msg.providers.title').toLowerCase() }}
        </p>
        <div
          v-else
          class="flex bg-gray-50"
          v-for="element in filterProviders"
          :key="element.id"
        >
          <div>
            <provider-item
              :provider="element"
              @update="updateProvider"
              @del="deleteProvider"
            />
          </div>
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
      loading: false,
      showingAdd: false,
      providers: [],
      searchQuery: '',
      dataCopied: false,
    };
  },
  components: {
    ProviderItem,
    ProvidersForm,
  },

  async created() {
    this.loading = true;
    try {
      const response = await getProviders();
      this.providers = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
      this.successResponse(response);
    } catch (error) {
      this.errorResponse(error);
    } finally {
      this.loading = false;
    }
  },
  methods: {
    closeAlert() {
      this.dataCopied = false;
    },

    toggleAddModal() {
      this.showingAdd = !this.showingAdd;
    },

    async addProvider(provider) {
      this.loading = true;
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
      } finally {
        this.loading = false;
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
  computed: {
    filterProviders() {
      if (this.searchQuery) {
        return this.providers.filter(provider => this.searchQuery
          .toLowerCase()
          .split(' ')
          .every(text => provider.name.toLowerCase().includes(text)));
      }

      return this.providers;
    },
  },
};

</script>
