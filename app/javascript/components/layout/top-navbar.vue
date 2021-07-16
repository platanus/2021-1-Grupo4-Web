<template>
  <nav class="flex flex-col z-50 h-20 sm:flex-row items-center justify-between bg-black sm:h-16">
    <!--Left Buttons -->
    <div class="flex items-center text-white ml-4">
      <a
        href="/"
        class="font-bold text-2xl tracking-wider"
      >
        KitchenGram
      </a>
    </div>
    <!--Right buttons -->
    <div class="flex w-full items-center justify-center sm:justify-end sm:pr-5">
      <!--Logged -->
      <template v-if="isCurrentUser">
        <div class="flex items-center relative">
          <button
            class="mr-4 focus:outline-none"
            @click="toggleAlerts(true)"
          >
            <img
              class="h-5 w-5 text-white"
              svg-inline
              src="../../../assets/images/bell-svg.svg"
            >
          </button>
          <div
            v-if="alertIngredients.length > 0"
          >
            <span class="absolute top-0 right-0 inline-block w-2 h-2 mr-4 transform translate-x-1/2 -translate-y-1/2 bg-red-600 rounded-full" />
          </div>
        </div>
        <dropdown
          :email="userEmail"
          @logout="logout"
          @profile="goToProfile"
        />
      </template>
    </div>
    <base-modal
      v-if="showAlerts"
      @ok="goToEditInventories"
      @cancel="toggleAlerts(false)"
      :title="$t('msg.ingredients.alerts')"
      :ok-button-label="$t('msg.ingredients.inventory.editInventories')"
      :cancel-button-label="$t('msg.close')"
    >
      <div
        class="w-8 h-8"
        v-if="this.alertLoading"
      >
        <base-spinner />
      </div>
      <div
        class="flex justify-between my-1 p-2 px-4 w-auto text-lg font-medium"
        v-if="!this.alertLoading"
      >
        {{ $t('msg.ingredients.alertIngredients') }}:
      </div>
      <div
        class="flex justify-between my-1 p-2 px-4 bg-gray-100 w-auto"
        v-if="alertIngredients.length == 0 && !this.alertLoading"
      >
        {{ $t('msg.ingredients.noAlert') }}
      </div>
      <div
        class="flex justify-between my-1 p-2 px-4 bg-red-100 w-auto"
        v-for="ingredient in alertIngredients"
        :key="ingredient.id"
      >
        <div>
          {{ ingredient.name }}
        </div>
        <div class="flex px-3">
          <div class="text-red-600 px-1">
            {{ ingredient.inventory }} {{ ingredient.measure }}
          </div>(Mínimo {{ ingredient.minimumQuantity }} {{ ingredient.measure }})
        </div>
      </div>
    </base-modal>
  </nav>
</template>

<script>

import { logoutUser } from './../../api/users.js';
import { getAlertedIngredients } from './../../api/ingredients.js';
import Dropdown from './dropdown-user.vue';

export default {

  props: {
    isCurrentUser: { type: Boolean, required: true },
  },
  components: {
    Dropdown,
  },

  data() {
    return {
      alertIngredients: [],
      showAlerts: false,
      alertLoading: true,
      error: '',
    };
  },

  computed: {
    logged() {
      return localStorage.getItem('token');
    },
    userEmail() {
      return localStorage.getItem('email');
    },
  },

  methods: {
    async logout() {
      localStorage.removeItem('token');
      await logoutUser();
      window.location.href = '/';
    },
    goToProfile() {
      window.location.href = '/profile';
    },
    async toggleAlerts(reload) {
      this.showAlerts = !this.showAlerts;
      if (reload) {
        this.alertLoading = true;
        try {
          const response = await getAlertedIngredients();
          this.alertIngredients = response.data.data.map((element) => ({
            id: element.id,
            ...element.attributes,
          }));
        } catch (error) {
          this.error = error;
        } finally {
          this.alertLoading = false;
        }
      }
    },
    goToEditInventories() {
      window.location = '/ingredients/update-inventories';
    },
  },
  async created() {
    try {
      if (!this.isCurrentUser) return;

      const response = await getAlertedIngredients();
      this.alertIngredients = response.data.data.map((element) => ({
        id: element.id,
        ...element.attributes,
      }));
    } catch (error) {
      this.error = error;
    }
  },
};

</script>
