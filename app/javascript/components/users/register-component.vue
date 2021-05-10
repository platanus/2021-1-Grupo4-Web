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
        {{ $t('msg.users.failRegister') }}
      </p>
    </div>

    <!--Title-->
    <h2 class="pb-5 text-4xl">
      {{ $t('msg.users.register') }}
    </h2>

    <!--Form-->
    <form
      @submit.prevent="register"
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
          v-model="form.userEmail"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="email"
          type="email"
          :placeholder="$t('msg.users.placeholderEmail')"
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
          v-model="form.userPassword"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="password"
          type="password"
          placeholder="******************"
        >
      <div>
        <message
        :mail="form.userEmail"/>
      </div>
      </div>
      <div class="flex items-center justify-between">
        <base-button
          :elements="{ placeholder: $t('msg.users.register'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
        />
      </div>
    </form>
  </div>
</template>

<script>

import { registerUser } from './../../api/users.js';

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

    async register() {
      try {
        const response = await registerUser(this.form.userEmail, this.form.userPassword);
        this.status = response.status;
        this.error = '';
        window.location.href = '/users/sign_in';
      } catch (error) {
        this.status = error.response.status;
        this.error = error;
      }
    },
  },

};

</script>
