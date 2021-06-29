<template>
  <nav class="flex items-center justify-between bg-black p-6 h-16">
    <!--Left Buttons -->
    <div class="flex items-center flex-shrink-0 text-white mr-6">
      <a
        href="/"
        class="font-semibold text-xl tracking-widest"
      >
        KitchenGram
      </a>
    </div>
    <!--Right buttons -->
    <div>
      <!--Logged -->
      <template v-if="logged">
        <button
          class="text-lg px-4 py-2 text-white rounded-md hover:bg-gray-900 focus:outline-none"
          @click="logout"
        >
          {{ $t('msg.users.logout') }}
        </button>
      </template>
      <!--Not Logged -->
      <template v-else>
        <a
          href="/users/sign_in"
          class="text-lg px-4 py-2 text-white rounded-md hover:bg-gray-900"
        >
          {{ $t('msg.users.login') }}
        </a>
      </template>
    </div>
  </nav>
</template>

<script>

import { logoutUser } from './../../api/users.js';

export default {

  computed: {
    logged() {
      return localStorage.getItem('token');
    },
  },

  methods: {
    async logout() {
      localStorage.removeItem('token');
      await logoutUser();
      window.location.href = '/';
    },
  },
};

</script>
