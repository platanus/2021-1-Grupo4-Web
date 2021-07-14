<template>
  <div class="relative">
    <button
      class="text-lg px-4 py-2 text-white rounded-md hover:bg-gray-900 lg:mt-0 focus:outline-none"
      @click="toggleDropdown"
    >
      {{ email }}
    </button>
    <div v-if="active">
      <div
        class=" absolute mt-0.5 right-0 w-auto bg-white border overflow-hidden rounded-lg shadow-md cursor-pointer z-10"
      >
        <ul>
          <li class="hover:bg-gray-100 w-auto">
            <a
              class="font-semibold block px-4 py-3"
              @click="goToProfile"
            >{{ $t('msg.users.myProfile') }}</a>
          </li>
          <li class="hover:bg-gray-100 w-auto">
            <a
              class="font-semibold block px-4 py-3"
              @click="logout"
            >{{ $t('msg.users.logout') }}</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    email: { type: String, required: true },
  },
  data() {
    return {
      active: false,
    };
  },
  mounted() {
    document.addEventListener('click', this.closeDropdown);
  },
  unmounted() {
    document.removeEventListener('click', this.closeDropdown);
  },
  methods: {
    closeDropdown(event) {
      if (event.target === this.$el || this.$el.contains(event.target)) return;
      this.active = false;
    },
    toggleDropdown() {
      this.active = !this.active;
    },
    logout() {
      this.$emit('logout');
      this.toggleDropdown();
    },
    goToProfile() {
      this.$emit('profile');
      this.toggleDropdown();
    },
  },
};
</script>
