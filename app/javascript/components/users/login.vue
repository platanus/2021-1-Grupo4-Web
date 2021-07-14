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
      <h2 class="text-xl text-gray-700">
        {{ $t(`msg.welcomeSubtitle`) }}
      </h2>
    </div>
    <div class="flex flex-col justify-center items-center p-12 bg-white rounded flex-none flex-grow-0 w-4/5 lg:w-1/2">
      <form
        @submit.prevent="login"
        method="post"
        class="w-full"
      >
        <h2 class="font-bold text-2xl text-black flex-none self-stretch flex-grow-0 mb-8">
          {{ $t('msg.users.login') }}
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
        <div class="mb-8 w-full">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="password"
          >
            {{ $t('msg.users.labelPassword') }}
          </label>
          <input
            class="flex items-start w-full py-5 px-4 bg-white border border-solid border-gray-200 rounded-md flex-none flex-grow-0"
            id="password"
            type="password"
            placeholder="******************"
            v-model="form.userPassword"
          >
          <p
            v-if="errors.password"
            class="mt-2 ml-1 text-xs text-red-400"
          >
            {{ $t(`msg.users.${errors.password}`) }}
          </p>
        </div>
        <div class="w-full flex flex-col lg:flex-row justify-between items-center flex-none self-stretch flex-grow-0 mb-8">
          <div class="font-normal text-base underline text-yellow-500 flex-none flex-grow-0 mb-1 mx-auto lg:mr-8">
            <a href="/users/sign_up">
              {{ $t('msg.users.notHaveAccount') }}
            </a>
          </div>
          <div class="mx-auto lg:m-0">
            <base-button
              :elements="{ placeholder: $t('msg.users.enter'),
                           color: 'bg-green-500 hover:bg-green-700 text-white' }"
            />
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>

import { loginUser } from '../../api/users.js';

export default {
  data() {
    return {
      form: {
        userEmail: '',
        userPassword: '',
      },
      errors: { email: '', password: '' },
    };
  },

  methods: {

    async login() {
      if (this.validations()) {
        try {
          const response = await loginUser(this.form.userEmail, this.form.userPassword);
          localStorage.setItem('token', response.data.data.attributes.authentication_token);
          localStorage.setItem('email', response.data.data.attributes.email);
          window.location.href = '/';
        } catch (error) {
          if (error.response.data.message === 'record_not_found') {
            this.errors.email = 'emailNotFound';
          }
          if (error.response.data.message === 'Invalid email or password') {
            this.errors.password = 'incorrectPassword';
          }
        }
      }
    },
    validations() {
      this.errors = { email: '', password: '' };
      let validForm = true;

      if (!this.form.userEmail) {
        this.errors.email = 'enterEmail';
        validForm = false;
      }
      if (!this.form.userPassword) {
        this.errors.password = 'enterPassword';
        validForm = false;
      }

      return validForm;
    },
  },
};

</script>
