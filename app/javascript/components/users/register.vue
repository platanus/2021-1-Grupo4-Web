<template>
  <div class="flex flex-col items-center bg-gray-200">
    <!-- mensaje bienvenida -->
    <div class="flex flex-col items-center flex-none flex-grow-0 mb-4">
      <img
        class="h-16 w-16 pt-4 m-auto text-white"
        svg-inline
        src="../../../assets/images/chef-svg.svg"
      >
      <h1 class="font-bold text-3xl text-gray-700 flex-none flex-grow-0 mb-1">
        {{ $t(`msg.welcomeTitle`) }}
      </h1>
      <h2 class="">
        {{ $t(`msg.welcomeSubtitle`) }}
      </h2>
    </div>
    <!-- form -->
    <div class="flex flex-col justify-center items-center p-12 bg-white rounded flex-none flex-grow-0 w-auto">
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
      <form
        @submit.prevent="register"
      >
        <h2 class="font-bold text-2xl text-black flex-none self-stretch flex-grow-0 mb-8">
          {{ $t('msg.users.register') }}
        </h2>
        <div class="w-full mb-8">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="email"
          >
            {{ $t('msg.users.labelEmail') }}
          </label>
          <input
            v-model="form.userEmail"
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
            id="email"
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
        <div class="mb-8 w-full">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="password"
          >
            {{ $t('msg.users.labelPassword') }}
          </label>
          <input
            v-model="form.userPassword"
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
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
        <div class="mb-8 w-full">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="password-confirmation"
          >
            {{ $t('msg.users.labelPasswordConfirmation') }}
          </label>
          <input
            v-model="form.passwordConfirmation"
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
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

        <div class=" w-auto flex justify-between items-end flex-none self-stretch flex-grow-0 mb-8">
          <div class="font-normal text-base underline text-yellow-500 flex-none flex-grow-0 mb-1 mr-8">
            <a href="/users/sign_in">
              {{ $t('msg.users.alreadyHaveAccount') }}
            </a>
          </div>
          <base-button
            :elements="{ placeholder: $t('msg.users.register'),
                         color: 'bg-green-500 hover:bg-green-700 text-white' }"
          />
        </div>
      </form>
    </div>
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

      const regexEmail = new RegExp(`${
        /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+/.source
      }${/(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@/.source
      }${/(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+/.source
      }${/[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/.source}`);
      if (!regexEmail.test(this.form.userEmail)) {
        this.errors.email = 'invalidEmail';
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
