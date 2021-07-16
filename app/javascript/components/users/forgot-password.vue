<template>
  <div class="flex flex-col items-center">
    <div class="flex flex-col justify-center items-center p-12 bg-white rounded flex-none flex-grow-0 w-4/5 lg:w-1/2">
      <form
        @submit.prevent="forgotPassword"
        method="post"
        class="w-full"
      >
        <h2 class="font-bold text-2xl text-black flex-none self-stretch flex-grow-0 mb-8">
          {{ $t('msg.users.forgotPassword') }}
        </h2>
        <div class="w-full mb-8">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="email"
          >
            {{ $t('msg.users.labelEmail') }}
          </label>
          <input
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
            id="email"
            type="email"
            :placeholder="$t('msg.users.placeholderEmail')"
            v-model="form.userEmail"
          >
          <p
            v-if="errors.email"
            class="mt-2 ml-1 text-xs text-red-400"
          >
            {{ $t(`msg.users.${errors.email}`) }}
          </p>
        </div>
        <div class="mx-auto lg:m-0">
          <base-button
            :elements="{ placeholder: $t('msg.users.recoverPassword'),
                         color: 'bg-green-500 hover:bg-green-700 text-white' }"
          />
        </div>
      </form>
    </div>
  </div>
</template>

<script>

import { forgotPassword } from '../../api/users.js';

export default {
  data() {
    return {
      form: {
        userEmail: '',
      },
      errors: { email: '' },
    };
  },

  methods: {

    async forgotPassword() {
      if (this.validations()) {
        try {
          await forgotPassword(this.form.userEmail);
          window.location.href = '/';
        } catch (error) {
          if (error.response.data.message === 'record_not_found') {
            this.errors.email = 'emailNotFound';
          }
        }
      }
    },
    validations() {
      this.errors = { email: '' };
      let validForm = true;

      if (!this.form.userEmail) {
        this.errors.email = 'enterEmail';
        validForm = false;
      }

      return validForm;
    },
  },
};

</script>
