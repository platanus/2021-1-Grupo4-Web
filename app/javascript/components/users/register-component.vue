<template>
  <div class="w-full max-w-xs">
    <h2 class="pb-5 text-4xl">
      {{ $t('msg.users.register') }}
    </h2>
    <form @submit.prevent="addUser" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
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
        >
      </div>
      <div class="flex items-center justify-between">
        <base-button
          :elements="{ placeholder: $t('msg.users.register'),
                       color: 'bg-green-500 hover:bg-green-700 text-white' }"
        />
      </div>
    </form>
    <div>{{ error }}</div>
  </div>
</template>

<script>

import axios from 'axios';

export default {
  data() {
    return {
      error: '',
    };
  },

  methods: {
    addUser() {
      axios
        .post('http://localhost:3000/api/v1/users/registrations', {
          user: {
            email: 'vale123456@uc.cl',
            password: '123456789',
          },
        })
        .then(response => {
          alert(response);
          this.error = response;
        })
        .catch(error => {
          alert(error);
          console.log(error);
          this.error = error;
        });
    },

  },

};

</script>
