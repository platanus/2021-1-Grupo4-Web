<template>
  <div class="flex flex-col m-auto p-2 sm:p-4 border-2 border-solid border-gray-400 box-border mb-6 w-full md:w-96 order-none">
    <div class="flex flex-row items-center self-stretch mb-4 px-1">
      <!-- Info -->
      <div class="flex flex-col">
        <!-- nombre Proveedor -->
        <div
          class="flex items-center cursor-pointer w-auto h-5 text-xl font-bold"
          @click="toggleOpenModal"
        >
          {{ provider.name }}
        </div>
        <div class="flex flex-col items-start w-auto h-10 my-4">
          <!-- Mail -->
          <div class="flex items-center w-auto h-5 mb-4">
            <!-- Icono -->
            <div class="w-4 h-4 mr-1.5">
              <img
                svg-inline
                src="../../../../assets/images/mail-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <div class="flex w-auto h-5 text-base items-center text-gray-400">
              <div
                v-if="!provider.email"
                class="text-base text-gray-300"
              >
                {{ $t('msg.providers.noInformation') }}
              </div>
              <div v-else>
                {{ provider.email }}
              </div>
            </div>
          </div>
          <!-- Telefono -->
          <div class="flex items-center w-auto h-5">
            <!-- Icono -->
            <div class="w-4 h-4 mr-1.5">
              <img
                svg-inline
                src="../../../../assets/images/phone-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <div class="flex w-auto h-5 text-base items-center text-gray-400">
              <div
                v-if="!provider.phone"
                class="text-base text-gray-300"
              >
                {{ $t('msg.providers.noInformation') }}
              </div>
              <div v-else>
                {{ provider.phone }}
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- flecha -->
      <div
        class="flex items-center w-6 h-6 justify-self-end"
        @click="toggleOpenModal"
      >
        <div
          v-if="showingDetails"
        >
          <img
            svg-inline
            src="../../../../assets/images/chevron-up-svg.svg"
            class="w-6 h-6 cursor-pointer"
          >
        </div>
        <div
          v-else
        >
          <img
            svg-inline
            src="../../../../assets/images/chevron-down-svg.svg"
            class="w-6 h-6 cursor-pointer"
          >
        </div>
      </div>
    </div>
    <div
      v-if="showingDetails"
    >
      <div class="flex flex-col items-center sm:items-start w-full">
        <!-- Pagina Web -->
        <div class="flex flex-col sm:flex-row items-center sm:items-start order-none w-full justify-between">
          <div class="flex flex-row items-center order-none w-48">
            <!-- Icono -->
            <div class="w-4 h-4 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/webpage-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex text-base items-center text-gray-400">
              {{ $t('msg.providers.webpageUrl') }}
            </p>
          </div>
          <!-- Link -->
          <div
            v-if="!provider.webpageUrl"
            class="flex text-base text-gray-300"
          >
            {{ $t('msg.providers.noInformation') }}
          </div>
          <div
            v-else
            class="flex items-center cursor-pointer underline text-gray-600 overflow-auto order-1 text-right justify-items-end max-w-full"
            @click="openWindow"
          >
            {{ provider.webpageUrl }}
          </div>
        </div>
        <!-- Datos bancarios -->
        <div class="flex flex-col sm:flex-row items-center sm:items-start order-none w-full justify-between">
          <div class="flex flex-row items-center order-none w-48">
            <!-- Icono -->
            <div class="w-4 h-4 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/credit-card-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex text-base items-center text-gray-400">
              {{ $t('msg.providers.bank') }}
            </p>
          </div>
          <!-- Boton ver datos -->
          <button
            class="flex items-center text-black text-right justify-items-end max-w-full bg-gray-100 border-2 rounded px-1"
            @click="toggleBankAccount"
          >
            {{ $t('msg.providers.see') }}
          </button>
        </div>
        <!-- Minimo Compra -->
        <div class="flex flex-col sm:flex-row items-center sm:items-start order-none w-full justify-between">
          <div class="flex flex-row items-center order-none w-48">
            <!-- Icono -->
            <div class="w-4 h-4 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/dolar-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex text-base items-center text-gray-400">
              {{ $t('msg.providers.minimumPurchase') }}
            </p>
          </div>
          <!-- Minimo -->
          <div
            v-if="!provider.minimumPurchase"
            class="flex text-base text-gray-300"
          >
            {{ $t('msg.providers.noInformation') }}
          </div>
          <p
            v-else
            class="flex items-center text-black order-1 flex-grow-0 text-right justify-items-end"
          >
            $ {{ provider.minimumPurchase }}
          </p>
        </div>
        <!-- Tiempo de Despacho -->
        <div class="flex flex-col sm:flex-row items-center sm:items-start order-none w-full justify-between mb-2">
          <div class="flex flex-row items-center order-none w-48">
            <!-- Icono -->
            <div class="w-4 h-4 m-1.5">
              <img
                svg-inline
                src="../../../../assets/images/car-svg.svg"
                class="w-4 h-4"
              >
            </div>
            <!-- Texto -->
            <p class="flex text-base items-center text-gray-400">
              {{ $t('msg.providers.deliveryDays') }}
            </p>
          </div>
          <!-- Tiempo -->
          <div
            v-if="!provider.deliveryDays"
            class="flex text-base text-gray-300"
          >
            {{ $t('msg.providers.noInformation') }}
          </div>
          <p
            v-else
            class="flex items-center text-black order-1 text-right justify-items-end"
          >
            {{ provider.deliveryDays }} {{ $t('msg.providers.days') }}
          </p>
        </div>
      </div>
      <!-- botones -->
      <div class="flex flex-col sm:flex-row items-center sm:items-start order-2 self-stretch w-full justify-between">
        <div class="pb-2 sm:pb-0">
          <button
            class="flex flex-row items-center justify-center border-2 border-red-600 hover:bg-gray-300 text-red-600 rounded order-1 flex-grow-1 px-2"
            @click="toggleDelModal"
          >
            {{ $t('msg.providers.delete') }}
          </button>
        </div>
        <div>
          <button
            class="flex flex-row items-center justify-center border-2 border-green-500 bg-green-500 hover:bg-green-700 hover:border-green-700 text-white rounded order-1 flex-grow-1 px-2"
            @click="toggleEditModal"
          >
            {{ $t('msg.providers.edit') }}
          </button>
        </div>
      </div>
    </div>
    <providers-form
      @edit-provider="editProvider"
      @toggle-edit-modal="toggleEditModal"
      v-if="showingEdit"
      :title="$t('msg.providers.edit')"
      :ok-button-label="$t('msg.save')"
      :cancel-button-label="$t('msg.cancel')"
      :showing-edit="showingEdit"
      :provider="providerToEdit"
    />
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
    <base-modal
      @ok="copyBankAccount"
      @cancel="toggleBankAccount"
      v-if="showBankAccount"
      :title="$t('msg.providers.bank')"
      :ok-button-label="$t('msg.providers.copy')"
      :cancel-button-label="$t('msg.close')"
      :ok-button-present="copyButtonAvailable"
    >
      <div
        v-if="provider.contactName && provider.contactRut && provider.bankName &&
          provider.accountType && provider.accountNumber && provider.email"
      >
        <p>
          {{ provider.contactName }}
        </p>
        <p>
          {{ provider.contactRut }}
        </p>
        <p>
          {{ provider.bankName }}
        </p>
        <p>
          {{ provider.accountType }}
        </p>
        <p>
          {{ provider.accountNumber }}
        </p>
        <p>
          {{ provider.email }}
        </p>
      </div>
      <div v-else>
        <p class="font-bold">
          {{ $t('msg.providers.dataMissing') }}
        </p>
        <br>
        <ul>
          <li v-if="!provider.contactName">
            {{ $t('msg.providers.bankAccount.name') }}
          </li>
          <li v-if="!provider.contactRut">
            {{ $t('msg.providers.bankAccount.rut') }}
          </li>
          <li v-if="!provider.bankName">
            {{ $t('msg.providers.bankAccount.bank') }}
          </li>
          <li v-if="!provider.accountType">
            {{ $t('msg.providers.bankAccount.type') }}
          </li>
          <li v-if="!provider.accountNumber">
            {{ $t('msg.providers.bankAccount.number') }}
          </li>
          <li v-if="!provider.email">
            {{ $t('msg.providers.email') }}
          </li>
        </ul>
      </div>
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
      showBankAccount: false,
      providerToDelete: {},
      providerToEdit: {},
    };
  },
  computed: {
    // eslint-disable-next-line complexity
    copyButtonAvailable() {
      if (this.provider.contactName && this.provider.contactRut && this.provider.bankName &&
          this.provider.accountType && this.provider.accountNumber && this.provider.email) {
        return true;
      }

      return false;
    },
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
    toggleBankAccount() {
      this.showBankAccount = !this.showBankAccount;
    },
    copyBankAccount() {
      const textToCopy = `${this.provider.contactName}\n${this.provider.contactRut}\n${this.provider.bankName
      }\n${this.provider.accountType}\n${this.provider.accountNumber}\n${this.provider.email}`;
      navigator.clipboard.writeText(textToCopy);
      this.toggleBankAccount();
      this.$emit('copied');
    },
    async editProvider(provider) {
      this.toggleEditModal();
      try {
        const res = await editProvider(this.providerToEdit.id, provider);
        this.$emit('update', res, this.providerToEdit.id);
      } catch (error) {
        this.$emit('error');
      }
    },
    async deleteProvider() {
      this.toggleDelModal();
      try {
        const response = await deleteProvider(this.providerToDelete.id);
        this.$emit('del', this.provider.id, response);
      } catch (error) {
        this.$emit('error');
      }
    },

    openWindow() {
      // eslint-disable-next-line no-magic-numbers
      // eslint-disable-next-line no-negated-condition
      const fullWebpageUrl = this.provider.webpageUrl
        // eslint-disable-next-line no-magic-numbers
        .slice(0, 5) !== 'https' ? `https://${this.provider.webpageUrl}` : this.provider.webpageUrl;
      window.open(fullWebpageUrl, '_blank');
    },
  },
};

</script>
