<template>
  <div class="w-full max-w-xs">
    <!--Alert-->
    <div
      v-if="error"
      class="bg-red-100 border-t border-b border-red-500 text-red-700 px-4 py-3 mb-4"
      role="alert"
    >
      <p
        class="font-bold"
      >
        {{ $t('msg.users.failLogin') }}
      </p>
    </div>

    <h2 class="pb-5 text-4xl">
      {{ $t('msg.users.login') }}
    </h2>
    <form
      @submit.prevent="login"
      method="post"
      class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
    >
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
          required
          v-model="form.userEmail"
        >
      </div>
      <div class="mb-6">
        <label
          class="block text-gray-700 text-sm font-bold mb-2"
          for="password"
        >
          {{ $t('msg.users.labelPassword') }}
        </label>
        <input
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="password"
          type="password"
          placeholder="******************"
          required
          v-model="form.userPassword"
        >
      </div>
      <div class="flex items-center justify-between">
        <base-button
          :elements="{ placeholder: $t('msg.users.login'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
        />
      </div>
    </form>
  </div>
</template>

<script>

import { loginUser } from './../../api/users.js';

export default {
  data() {
    return {
      form: {
        userEmail: '',
        userPassword: '',
      },
      status: '',
      error: '',
    };
  },

  methods: {

    async login() {
      try {
        const response = await loginUser(this.form.userEmail, this.form.userPassword);
        this.status = response.status;
        this.error = '';
        localStorage.setItem('token', response.data.data.attributes.authentication_token);
        localStorage.setItem('email', response.data.data.attributes.email);
        window.location.href = '/';
      } catch (error) {
        this.status = error.response.status;
        this.error = error;
      }
    },
  },
};

</script>
