<template>
  <nav class="flex items-center justify-between bg-gray-800 p-6 h-16">
    <div class="flex items-center flex-shrink-0 text-white mr-6">
      <!--App Logo -->
      <a
        href="/"
        class="font-semibold text-xl tracking-widest"
      >KitchenGram</a>
    </div>
    <div class="w-full flex-grow lg:flex lg:items-end lg:w-auto justify-end pr-5">
      <!--Login -->
      <a
        v-if="!logged"
        href="/users/sign_in"
        class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
      >
        {{ $t('msg.users.login') }}
      </a>
      <!--Register -->
      <a
        v-if="!logged"
        href="/users/sign_up"
        class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
      >
        {{ $t('msg.users.register') }}
      </a>
      <!--Logout -->
      <button
        v-if="logged"
        class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
        @click="logout"
      >
        {{ $t('msg.users.logout') }}
      </button>
    </div>
  </nav>
</template>

<script>

export default {

  computed: {
    logged() {
      return localStorage.getItem('token');
    },
  },

  methods: {
    logout() {
      localStorage.setItem('token', '');
      window.location.href = '/';
    },
  },
};

</script>
