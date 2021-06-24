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
    <div class="w-full flex-grow lg:flex lg:items-end lg:w-auto justify-end pr-5">
      <!--Logged -->
      <template v-if="isCurrentUser">
        <button
          class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0 focus:outline-none"
          @click="logout"
        >
          {{ $t('msg.users.logout') }}
        </button>
      </template>
      <!--Not Logged -->
      <template v-else>
        <a
          href="/users/sign_in"
          class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
        >
          {{ $t('msg.users.login') }}
        </a>
        <a
          href="/users/sign_up"
          class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
        >
          {{ $t('msg.users.register') }}
        </a>
      </template>
    </div>
  </nav>
</template>

<script>

import { logoutUser } from './../../api/users.js';

export default {

  props: {
    isCurrentUser: { type: Boolean, required: true },
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
