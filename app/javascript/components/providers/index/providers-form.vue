<template>
  <div>
    <base-modal
      @ok="addProvider"
      @cancel="$emit('toggle-add-modal')"
      v-if="showingAdd"
      :title="$t('msg.providers.add')"
      :ok-button-label="$t('msg.add')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <div class="pt-3">
        <form class="w-full max-w-lg">
          <div class="flex flex-wrap -mx-3 mb-3">
            <div class="w-full px-3">
              <!--Name -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-name"
              >
                {{ $t('msg.providers.name') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-name"
                type="text"
                :placeholder="$t('msg.providers.name')"
                v-model="form.name"
              >
              <p
                v-if="errors.name"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.name}`) }}
              </p>
            </div>
          </div>
          <div class="flex flex-wrap -mx-3 mb-3">
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
              <!--Correo -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-email"
              >
                {{ $t('msg.providers.email') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-email"
                type="text"
                :placeholder="$t('msg.providers.email')"
                v-model="form.email"
              >
              <p
                v-if="errors.email"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.email}`) }}
              </p>
              <!--Phone -->
            </div>
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-phone"
              >
                {{ $t('msg.providers.phone') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-phone"
                type="text"
                :placeholder="'+569'"
                v-model="form.phone"
              >
              <p
                v-if="errors.phone"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.phone}`) }}
              </p>
            </div>
          </div>

          <div class="flex flex-wrap -mx-3 mb-3">
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
              <!--WebpageUrl -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-webpageUrl"
              >
                {{ $t('msg.providers.webpageUrl') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-webpageUrl"
                type="text"
                :placeholder="$t('msg.providers.webpageUrl')"
                v-model="form.webpageUrl"
              >
              <p
                v-if="errors.webpageUrl"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.webpageUrl}`) }}
              </p>
            </div>
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
              <!--DeliberyDays -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-deliveryDays"
              >
                {{ $t('msg.providers.deliveryDays') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-deliveryDays"
                type="text"
                :placeholder="$t('msg.providers.deliveryDays')"
                v-model="form.deliveryDays"
              >
              <p
                v-if="errors.deliveryDays"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.deliveryDays}`) }}
              </p>
            </div>
          </div>
          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full px-3">
              <!--minimumPurchase -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-minimumPurchase"
              >
                {{ $t('msg.providers.minimumPurchase') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-minimumPurchase"
                type="text"
                :placeholder="$t('msg.providers.minimumPurchase')"
                v-model="form.minimumPurchase"
              >
              <p
                v-if="errors.minimumPurchase"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.minimumPurchase}`) }}
              </p>
            </div>
          </div>
          <!-- Datos bancarios -->
          <div class="flex flex-wrap -mx-3">
            <div class="w-full px-3">
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-bankAccount"
              >
                {{ $t('msg.providers.bank') }}
              </label>
              <!-- contact name -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-contactName"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.name')"
                v-model="form.contactName"
              >
              <p
                v-if="errors.contactName"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.contactName}`) }}
              </p>
              <!-- account rut -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-contactRut"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.rut')"
                v-model="form.contactRut"
              >
              <p
                v-if="errors.contactRut"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.contactRut}`) }}
              </p>
              <!-- bank name -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-bankName"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.bank')"
                v-model="form.bankName"
              >
              <p
                v-if="errors.bankName"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.bankName}`) }}
              </p>
              <!-- account type -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountType"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.type')"
                v-model="form.accountType"
              >
              <p
                v-if="errors.accountType"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.accountType}`) }}
              </p>
              <!-- account number -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountNumber"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.number')"
                v-model="form.accountNumber"
              >
              <p
                v-if="errors.accountNumber"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.accountNumber}`) }}
              </p>
            </div>
          </div>
        </form>
      </div>
    </base-modal>
    <base-modal
      @ok="editProvider"
      @cancel="$emit('toggle-edit-modal')"
      v-if="showingEdit"
      :title="$t('msg.providers.edit')"
      :ok-button-label="$t('msg.save')"
      :cancel-button-label="$t('msg.cancel')"
    >
      <div class="pt-3">
        <form class="w-full max-w-lg">
          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full px-3">
              <!--Name -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-name"
              >
                {{ $t('msg.providers.name') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-name"
                type="text"
                :placeholder="$t('msg.providers.name')"
                v-model="form.name"
              >
              <p
                v-if="errors.name"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.name}`) }}
              </p>
            </div>
          </div>

          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
              <!--Correo -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-email"
              >
                {{ $t('msg.providers.email') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-email"
                type="text"
                :placeholder="$t('msg.providers.email')"
                v-model="form.email"
              >
              <p
                v-if="errors.email"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.email}`) }}
              </p>
              <!--Phone -->
            </div>
            <div class="relative">
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-phone"
              >
                {{ $t('msg.providers.phone') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-phone"
                type="text"
                :placeholder="'+569'"
                v-model="form.phone"
              >
              <p
                v-if="errors.phone"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.phone}`) }}
              </p>
            </div>
          </div>
          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
              <!--WebpageUrl -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-webpageUrl"
              >
                {{ $t('msg.providers.webpageUrl') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-webpageUrl"
                type="text"
                :placeholder="$t('msg.providers.webpageUrl')"
                v-model="form.webpageUrl"
              >
              <p
                v-if="errors.webpageUrl"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.webpageUrl}`) }}
              </p>
            </div>
            <div class="relative">
              <!--DeliveryDays -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-deliveryDays"
              >
                {{ $t('msg.providers.deliveryDays') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-deliveryDays"
                type="text"
                :placeholder="$t('msg.providers.deliveryDays')"
                v-model="form.deliveryDays"
              >
              <p
                v-if="errors.deliveryDays"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.deliveryDays}`) }}
              </p>
            </div>
          </div>
          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full px-3">
              <!--minimumPurchase -->
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-minimumPurchase"
              >
                {{ $t('msg.providers.minimumPurchase') }}
              </label>
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-minimumPurchase"
                type="text"
                :placeholder="$t('msg.providers.minimumPurchase')"
                v-model="form.minimumPurchase"
              >
              <p
                v-if="errors.minimumPurchase"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.minimumPurchase}`) }}
              </p>
            </div>
          </div>
          <!-- Datos bancarios -->
          <div class="flex flex-wrap -mx-3 mb-6">
            <div class="w-full px-3">
              <label
                class="block text-gray-700 text-sm font-bold mb-2"
                for="provider-bankAccount"
              >
                {{ $t('msg.providers.bank') }}
              </label>
              <!-- contact name -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-contactName"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.name')"
                v-model="form.contactName"
              >
              <p
                v-if="errors.contactName"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.contactName}`) }}
              </p>
              <!-- account rut -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-contactRut"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.rut')"
                v-model="form.contactRut"
              >
              <p
                v-if="errors.contactRut"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.contactRut}`) }}
              </p>
              <!-- bank name -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-bankName"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.bank')"
                v-model="form.bankName"
              >
              <p
                v-if="errors.bankName"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.bankName}`) }}
              </p>
              <!-- account type -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountType"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.type')"
                v-model="form.accountType"
              >
              <p
                v-if="errors.accountType"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.accountType}`) }}
              </p>
              <!-- account number -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountNumber"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.number')"
                v-model="form.accountNumber"
              >
              <p
                v-if="errors.accountNumber"
                class="mt-2 ml-1 text-xs text-red-400"
              >
                {{ $t(`msg.${errors.accountNumber}`) }}
              </p>
            </div>
          </div>
        </form>
      </div>
    </base-modal>
  </div>
</template>

<script>

export default {
  props: {
    provider: { type: Object, default() {
      return {};
    } },
    showingAdd: { type: Boolean },
    showingEdit: { type: Boolean },
  },

  data() {
    return {
      form: {
        name: '',
        email: '',
        webpageUrl: '',
        minimumPurchase: '',
        deliveryDays: '',
        phone: '',
        contactName: '',
        contactRut: '',
        bankName: '',
        accountType: '',
        accountNumber: '',
      },
      errors: {
        name: '',
        email: '',
        webpageUrl: '',
        minimumPurchase: '',
        deliveryDays: '',
        phone: '',
        contactName: '',
        contactRut: '',
        bankName: '',
        accountType: '',
        accountNumber: '',
      },
    };
  },

  created() {
    const {
      name,
      email,
      webpageUrl,
      minimumPurchase,
      deliveryDays,
      phone,
      contactName,
      contactRut,
      bankName,
      accountType,
      accountNumber,
    } = this.provider;

    this.form = {
      name,
      email,
      webpageUrl,
      minimumPurchase,
      deliveryDays,
      phone,
      contactName,
      contactRut,
      bankName,
      accountType,
      accountNumber,
    };
  },

  methods: {
    addProvider() {
      if (this.validations()) {
        this.$emit('add-provider', this.form);
      }
    },

    editProvider() {
      if (this.validations()) {
        this.$emit('edit-provider', this.form);
      }
    },

    // eslint-disable-next-line max-statements,complexity
    validations() {
      this.errors = {
        name: '',
        email: '',
        webpageUrl: '',
        minimumPurchase: '',
        deliveryDays: '',
        phone: '',
        contactName: '',
        contactRut: '',
        bankName: '',
        accountType: '',
        accountNumber: '',
      };

      const minPurchaseCond = !(Number.isInteger(this.form.minimumPurchase - 0)) || !(this.form.minimumPurchase >= 0);
      if (this.form.minimumPurchase && minPurchaseCond) {
        this.errors.minimumPurchase = 'intGeqZero';
      }

      if (this.form.deliveryDays && !(this.form.deliveryDays >= 0)) {
        this.errors.deliveryDays = 'geqZero';
      }

      const regexEmail = new RegExp(`${
        /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+/.source
      }${/(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@/.source
      }${/(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+/.source
      }${/[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/.source}`);
      if (this.form.email && !regexEmail.test(this.form.email)) {
        this.errors.email = 'invalidEmail';
      }

      if (!this.form.name) {
        this.errors.name = 'requiredField';
      }

      const bankData = [
        this.form.contactName,
        this.form.contactRut,
        this.form.bankName,
        this.form.accountType,
        this.form.accountNumber,
      ];
      if (bankData.some(data => !!data)) {
        if (!this.form.contactName) {
          this.errors.contactName = 'requiredField';
        }
        if (!this.form.contactRut) {
          this.errors.contactRut = 'requiredField';
        }
        if (!this.form.bankName) {
          this.errors.bankName = 'requiredField';
        }
        if (!this.form.accountType) {
          this.errors.accountType = 'requiredField';
        }
        if (!this.form.accountNumber) {
          this.errors.accountNumber = 'requiredField';
        }
      }

      const validForm = !(Object.values(this.errors).some(value => !!value));

      return validForm;
    },
  },
};

</script>
