<template>
  <div class="flex flex-col items-start p-4 border-2 border-solid border-gray-400 box-border flex-none flex-grow-0 mb-6 w-96 order-none">
    <div class="flex flex-row items-center w-auto h-auto flex-none self-stretch flex-grow-0 my-4 px-3">
      <!-- Imagen -->
      <div class="w-24 h-24 border-2 border-solid border-gray-400 box-border flex-none flex-grow-0 mr-2 order-none" />
      <!-- Info -->
      <div class="flex flex-col items-start w-auto h-auto flex-none self-stretch flex-grow mr-2">
        <!-- nombre Proveedor -->
        <div class="flex items-center w-auto h-5 flex-none flex-grow-0">
          {{ provider.name }}
        </div>
        <div class="flex flex-col items-start w-auto h-10 flex-none flex-grow-0 my-4">
          <!-- Mail -->
          <div class="flex items-center w-auto h-5 flex-none flex-grow-0 mb-4">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/mail-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <div class="flex w-auto h-5 font-normal font-sans text-base items-center text-gray-400 flex-grow-0 flex-none">
              {{ provider.email }}
            </div>
          </div>
          <!-- Telefono -->
          <div class="flex items-center w-auto h-5 flex-none flex-grow-0">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/phone-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <div class="flex w-auto h-5 font-normal font-sans text-base items-center text-gray-400 flex-grow-0 flex-none">
              {{ provider.phone }}
            </div>
          </div>
        </div>
      </div>
      <!-- flecha -->
      <div
        class="flex items-center w-6 h-6 flex-none self-stretch justify-self-end"
        @click="toggleOpenModal"
      >
        <img
          svg-inline
          src="../../../../assets/images/chevron-down-svg.svg"
          class="w-6 h-6"
        >
      </div>
    </div>
    <div
      v-if="this.showingDetails"
    >
      <div class="flex flex-col items-start flex-none order-1 flex-grow-0 w-80 mr-1">
        <!-- Pagina Web -->
        <div class="flex flex-row items-start flex-none order-none flex-grow-0 w-full justify-between">
          <div class="flex flex-row flex-none items-center order-none flex-grow-0 w-48">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/webpage-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex font-normal font-sans text-base items-center text-gray-400 underline">
              Página Web
            </p>
          </div>
          <!-- Link -->
          <div
            class="flex items-center underline text-blue-700 overflow-scroll font-normal font-sans order-1 text-right justify-items-end max-w-full"
            @click="openWindow"
          >
            {{ provider.webpageUrl }}
          </div>
        </div>
        <!-- Minimo Compra -->
        <div class="flex flex-row items-start flex-none order-none flex-grow-0 w-full justify-between">
          <div class="flex flex-row flex-none items-center order-none flex-grow-0 w-48">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/dolar-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex font-normal font-sans text-base items-center text-gray-400">
              Mínimo de Compra
            </p>
          </div>
          <!-- Minimo -->
          <p class="flex items-center text-black font-normal font-sans flex-none order-1 flex-grow-0 text-right justify-items-end">
            $ {{ provider.minimumPurchase }}
          </p>
        </div>
        <!-- Tiempo de Despacho -->
        <div class="flex flex-row items-start flex-none order-none flex-grow-0 w-full justify-between mb-2">
          <div class="flex flex-row flex-none items-center order-none flex-grow-0 w-48">
            <!-- Icono -->
            <div class="w-4 h-4 flex-none flex-grow-0 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/car-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex font-normal font-sans text-base items-center text-gray-400">
              Tiempo de Despacho
            </p>
          </div>
          <!-- Tiempo -->
          <p class="flex items-center text-black font-normal font-sans flex-none order-1 flex-grow-0 text-right justify-items-end">
            {{ provider.deliveryDays }} días
          </p>
        </div>
      </div>
      <div class="flex flex-row items-start flex-none order-2 flex-grow-0 self-stretch w-full justify-between mx-2">
        <div>
          <button
            class="flex flex-row items-center justify-center bg-blue-700 text-white rounded flex-none order-1 flex-grow-1 px-2"
            @click="toggleDelModal"
          >
            Eliminar Proveedor
          </button>
        </div>
        <div>
          <button
            class="flex flex-row items-center justify-center text-blue-700 bg-white rounded flex-none order-1 flex-grow-1 px-2"
            @click="toggleEditModal"
          >
            Editar Proveedor
          </button>
        </div>
      </div>
    </div>
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
      :cancel-button-label="$t('msg.cancel')"
    >
      <p>{{ $t('msg.providers.deleteMsg') }}</p>
    </base-modal>
  </div>
</template>

<script>
import ProvidersForm from './providers-form';
import { deleteProvider, editProvider } from './../../../api/providers.js';

export default {
  props: {
    provider: { type: Object, required: true },
  },
  components: {
    ProvidersForm,
  },
  data() {
    return {
      showingDetails: false,
      showingDel: false,
      showingEdit: false,
      providerToDelete: {},
      providerToEdit: {},
    };
  },
  methods: {
    toggleOpenModal(provider) {
      this.showingDetails = !this.showingDetails;
      this.providerToOpen = provider;
    },
    toggleDelModal() {
      this.showingDel = !this.showingDel;
      this.providerToDelete = this.provider;
    },
    toggleEditModal() {
      this.showingEdit = !this.showingEdit;
      this.providerToEdit = this.provider;
    },
    async editProvider() {
      try {
        // eslint-disable-next-line no-magic-numbers
        const firstElementsWeb = this.$refs.editProviderInfo.form.webpageUrl.slice(0, 5);
        if (firstElementsWeb !== 'https') {
          // eslint-disable-next-line vue/no-mutating-props
          this.$refs.editProviderInfo.form.webpageUrl = `https://${this.$refs.editProviderInfo.form.webpageUrl}`;
        }
      // eslint-disable-next-line no-empty
      } catch (error) {
      }
      this.showingEdit = !this.showingEdit;
      try {
        const res = await editProvider(this.providerToEdit.id, this.$refs.editProviderInfo.form);
        this.$emit('update', res, this.providerToEdit.id);
      } catch (error) {
        this.errorResponse(error);
      }
    },

    async deleteProvider() {
      try {
        const response = await deleteProvider(this.providerToDelete.id);
        this.$emit('del', this.provider.id, response);
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
    openWindow() {
      console.log('entre al window');
      // eslint-disable-next-line no-magic-numbers
      window.open(this.provider.webpageUrl, '_blank');
    },
  },
};

</script>
