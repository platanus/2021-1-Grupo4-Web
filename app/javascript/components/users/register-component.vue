<template>
  <div class="w-full max-w-xs">
    <!--Alert-->
    <div
      v-if="status!==''"
      class="bg-blue-100 border-t border-b border-blue-500 text-blue-700 px-4 py-3 mb-3"
      role="alert"
    >
      <p
        v-if="status===201"
        class="font-bold"
      >
        {{ $t('msg.users.successRegister') }}
      </p>
      <p
        v-if="status===400"
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

import axios from 'axios';

export default {
  data() {
    return {
      form: {
        userEmail: '',
        userPassword: '',
      },
      status: '',
      userToken: '',
      error: '',
    };
  },

  methods: {
    register() {
      axios
        .post('http://localhost:3000/api/v1/users/registrations', {
          user: {
            email: this.form.userEmail,
            password: this.form.userPassword,
          },
        })
        .then(response => {
          this.status = response.status;
          this.userToken = response.data.data.attributes.authentication_token;
          this.resetForm();
        })
        .catch(error => {
          this.status = 400;
          this.error = error;
        });
    },

    resetForm() {
      Object.keys(this.form).forEach((key) => {
        this.form[key] = '';
      });
    },

  },

};

</script>
