<template>
  <nav class="flex items-center justify-between bg-gray-800 p-6 h-16">
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
      <template v-if="logged">
        <button
          class="text-lg px-4 py-2 text-white hover:bg-gray-900 mt-4 lg:mt-0"
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

export default {

  computed: {
    logged() {
      return localStorage.getItem('token');
    },
  },

  methods: {
    logout() {
      localStorage.removeItem('token');
      window.location.href = '/';
    },
  },
};

</script>
