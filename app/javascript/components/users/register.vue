<template>
  <div class="m-auto max-w-xs">
    <!-- Alert -->
    <div
      v-if="takenEmailAlert"
      class="mb-4 bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative"
      role="alert"
    >
      <span class="block sm:inline">{{ takenEmailAlert[0] }}</span>
      <span
        class="absolute top-0 bottom-0 right-0 px-4 py-3 cursor-pointer"
        @click="closeAlert"
      >
        <img
          svg-inline
          src="../../../assets/images/cancel-red-svg.svg"
          class="h-5 w-5 text-red-700"
        >
      </span>
    </div>

    <!--Form-->
    <form
      @submit.prevent="register"
      class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
    >
      <h2 class="pb-5 text-4xl text-center">
        {{ $t('msg.users.register') }}
      </h2>
      <div class="mb-4">
        <label
          class="block text-gray-700 text-sm font-bold mb-2"
          for="email"
        >
          {{ $t('msg.users.labelEmail') }}
        </label>
        <input
          v-model="form.userEmail"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="email"
          type="email"
          :placeholder="$t('msg.users.placeholderEmail')"
        >
        <p
          v-if="errors.email"
          class="mt-2 ml-1 text-xs text-red-400"
        >
          {{ $t(`msg.users.${errors.email}`) }}
        </p>
      </div>
      <!-- Password -->
      <div class="mb-6">
        <label
          class="block text-gray-700 text-sm font-bold mb-2"
          for="password"
        >
          {{ $t('msg.users.labelPassword') }}
        </label>
        <input
          v-model="form.userPassword"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="password"
          type="password"
          placeholder="******************"
        >
        <p
          v-if="errors.password"
          class="mt-2 ml-1 text-xs text-red-400"
        >
          {{ $t(`msg.users.${errors.password}`) }}
        </p>
      </div>
      <!-- Password Confirmation -->
      <div class="mb-6">
        <label
          class="block text-gray-700 text-sm font-bold mb-2"
          for="password-confirmation"
        >
          {{ $t('msg.users.labelPasswordConfirmation') }}
        </label>
        <input
          v-model="form.passwordConfirmation"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="password-confirmation"
          type="password"
          placeholder="******************"
        >
        <p
          v-if="errors.passwordConfirmation"
          class="mt-2 ml-1 text-xs text-red-400"
        >
          {{ $t(`msg.users.${errors.passwordConfirmation}`) }}
        </p>
      </div>
      <!-- Button -->
      <div class="flex items-center justify-between mt-3">
        <base-button
          :elements="{ placeholder: $t('msg.users.register'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
        />
      </div>
      <div class="text-gray-700 text-center text-sm font-bold pt-2">
        <a href="/users/sign_in">
          {{ $t('msg.users.alreadyHaveAccount') }}
        </a>
      </div>
    </form>
  </div>
</template>

<script>

import { registerUser } from '../../api/users.js';

export default {
  data() {
    return {
      form: {
        userEmail: '',
        userPassword: '',
        passwordConfirmation: '',
      },
      errors: { email: '', password: '', passwordConfirmation: '' },
      takenEmailAlert: '',
    };
  },

  methods: {

    async register() {
      if (this.validations()) {
        try {
          const response = await registerUser(this.form.userEmail, this.form.userPassword);
          localStorage.setItem('token', response.data.data.attributes.authentication_token);
          localStorage.setItem('email', response.data.data.attributes.email);
          window.location.href = '/';
        } catch (error) {
          this.takenEmailAlert = error.response.data.errors.email;
        }
      }
    },
    // eslint-disable-next-line max-statements,complexity
    validations() {
      this.errors = { email: '', password: '', passwordConfirmation: '' };
      let validForm = true;

      const minPasswordLen = 6;
      if (!(this.form.userPassword.length >= minPasswordLen)) {
        this.errors.password = 'passwordTooShort';
        validForm = false;
      }

      if (this.form.userPassword !== this.form.passwordConfirmation) {
        this.errors.passwordConfirmation = 'passwordConfirmationIncorrect';
        validForm = false;
      }

      if (!this.form.userEmail) {
        this.errors.email = 'requiredEmail';
        validForm = false;
      }

      if (!this.form.userPassword) {
        this.errors.password = 'requiredPassword';
        validForm = false;
      }
      if (!this.form.passwordConfirmation) {
        this.errors.passwordConfirmation = 'requiredPasswordConfirmation';
        validForm = false;
      }

      return validForm;
    },

    closeAlert() {
      this.takenEmailAlert = '';
    },
  },

};

</script>
