<template>
  <div class="m-auto max-w-xs">
    <form
      @submit.prevent="login"
      method="post"
      class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
    >
      <h2 class="pb-5 text-4xl text-center">
        {{ $t('msg.users.login') }}
      </h2>
      <div class="mb-4">
        <label
          class="block text-gray-700 text-sm font-bold mb-2"
          for="email"
        >
          {{ $t('msg.users.labelEmail') }}
        </label>
        <input
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
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
      <div class="mb-4">
        <label
          class="block text-gray-700 text-sm font-bold mb-2"
          for="password"
        >
          {{ $t('msg.users.labelPassword') }}
        </label>
        <input
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
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
      <div class="flex items-center justify-between">
        <base-button
          :elements="{ placeholder: $t('msg.users.login'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
        />
      </div>
      <div class="text-gray-700 text-center text-sm font-bold pt-2">
        <a href="/users/sign_up">
          {{ $t('msg.users.notHaveAccount') }}
        </a>
      </div>
    </form>
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
