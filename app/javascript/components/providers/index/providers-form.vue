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
              <base-error-paragraph
                :msg-error="errors.name"
              />
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
              <base-error-paragraph
                :msg-error="errors.email"
              />
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
              <base-error-paragraph
                :msg-error="errors.phone"
              />
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
              <base-error-paragraph
                :msg-error="errors.webpageUrl"
              />
            </div>
            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
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
              <base-error-paragraph
                :msg-error="errors.deliveryDays"
              />
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
              <base-error-paragraph
                :msg-error="errors.minimumPurchase"
              />
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
              <base-error-paragraph
                :msg-error="errors.contactName"
              />
              <!-- account rut -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-contactRut"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.rut')"
                v-model="form.contactRut"
              >
              <base-error-paragraph
                :msg-error="errors.contactRut"
              />
              <!-- bank name -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-bankName"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.bank')"
                v-model="form.bankName"
              >
              <base-error-paragraph
                :msg-error="errors.bankName"
              />
              <!-- account type -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountType"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.type')"
                v-model="form.accountType"
              >
              <base-error-paragraph
                :msg-error="errors.accountType"
              />
              <!-- account number -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountNumber"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.number')"
                v-model="form.accountNumber"
              >
              <base-error-paragraph
                :msg-error="errors.accountNumber"
              />
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
              <base-error-paragraph
                :msg-error="errors.name"
              />
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
              <base-error-paragraph
                :msg-error="errors.email"
              />
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
              <base-error-paragraph
                :msg-error="errors.phone"
              />
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
              <base-error-paragraph
                :msg-error="errors.webpageUrl"
              />
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
              <base-error-paragraph
                :msg-error="errors.deliveryDays"
              />
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
              <base-error-paragraph
                :msg-error="errors.minimumPurchase"
              />
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
              <base-error-paragraph
                :msg-error="errors.contactName"
              />
              <!-- account rut -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-contactRut"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.rut')"
                v-model="form.contactRut"
              >
              <base-error-paragraph
                :msg-error="errors.contactRut"
              />
              <!-- bank name -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-bankName"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.bank')"
                v-model="form.bankName"
              >
              <base-error-paragraph
                :msg-error="errors.bankName"
              />
              <!-- account type -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountType"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.type')"
                v-model="form.accountType"
              >
              <base-error-paragraph
                :msg-error="errors.accountType"
              />
              <!-- account number -->
              <input
                class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
                id="provider-accountNumber"
                type="text"
                :placeholder="$t('msg.providers.bankAccount.number')"
                v-model="form.accountNumber"
              >
              <base-error-paragraph
                :msg-error="errors.accountNumber"
              />
            </div>
          </div>
        </form>
      </div>
    </base-modal>
  </div>
</template>

<script>
import { geqZero, intGeqZero, requiredField, validEmail } from '../../../utils/validations.js';

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

    // eslint-disable-next-line max-statements
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

      this.errors.minimumPurchase = intGeqZero(this.form.minimumPurchase, this.errors.minimumPurchase);
      this.errors.deliveryDays = geqZero(this.form.deliveryDays, this.errors.deliveryDays);
      this.errors.email = validEmail(this.form.email, this.errors.email);
      this.errors.name = requiredField(this.form.name, this.errors.name);

      const bankData = [
        this.form.contactName,
        this.form.contactRut,
        this.form.bankName,
        this.form.accountType,
        this.form.accountNumber,
      ];
      if (bankData.some(data => !!data)) {
        this.errors.contactName = requiredField(this.form.contactName, this.errors.contactName);
        this.errors.contactRut = requiredField(this.form.contactRut, this.errors.contactRut);
        this.errors.bankName = requiredField(this.form.bankName, this.errors.bankName);
        this.errors.accountType = requiredField(this.form.accountType, this.errors.accountType);
        this.errors.accountNumber = requiredField(this.form.accountNumber, this.errors.accountNumber);
        this.errors.email = requiredField(this.form.email, this.errors.email);
      }

      const validForm = !(Object.values(this.errors).some(value => !!value));

      return validForm;
    },
  },
};

</script>
