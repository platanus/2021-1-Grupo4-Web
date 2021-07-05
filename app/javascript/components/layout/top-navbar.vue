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
    <div class="w-full flex-grow lg:flex items-center lg:w-auto justify-end pr-5">
      <!--Logged -->
      <template v-if="isCurrentUser">
        <div class="relative">
          <button
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
            <span class="absolute top-0 right-0 inline-block w-2 h-2 transform translate-x-1/2 -translate-y-1/2 bg-red-600 rounded-full" />
          </div>
        </div>
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
          class="text-lg px-4 py-2 text-white rounded-md hover:bg-gray-900"
        >
          {{ $t('msg.users.login') }}
        </a>
      </template>
    </div>
    <base-modal
      v-if="showAlerts"
      @ok="toggleAlerts(false)"
      @cancel="toggleAlerts(false)"
      :title="$t('msg.ingredients.alerts')"
      :ok-button-present="false"
      :cancel-button-label="$t('msg.close')"
    >
      <div
        class="w-8 h-8"
        v-if="this.alertLoading"
      >
        <base-spinner />
      </div>
      <div
        class="flex justify-between my-1 p-2 px-4 w-96 text-lg font-medium"
        v-if="!this.alertLoading"
      >
        {{ $t('msg.ingredients.alertIngredients') }}:
      </div>
      <div
        class="flex justify-between my-1 p-2 px-4 bg-gray-100 w-96"
        v-if="alertIngredients.length == 0 && !this.alertLoading"
      >
        {{ $t('msg.ingredients.noAlert') }}
      </div>
      <div
        class="flex justify-between my-1 p-2 px-4 bg-red-100 w-96"
        v-for="ingredient in alertIngredients"
        :key="ingredient.id"
      >
        <div>
          {{ ingredient.name }}
        </div>
        <div class="flex">
          <div class="text-red-600">
            {{ ingredient.inventory }}
          </div>/{{ ingredient.minimumQuantity }} {{ ingredient.measure }}
        </div>
      </div>
    </base-modal>
  </nav>
</template>

<script>

import { logoutUser } from './../../api/users.js';
import { getAlertedIngredients } from './../../api/ingredients.js';

export default {

  props: {
    isCurrentUser: { type: Boolean, required: true },
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
  },

  methods: {
    async logout() {
      localStorage.removeItem('token');
      await logoutUser();
      window.location.href = '/';
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
  },
  async created() {
    try {
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
