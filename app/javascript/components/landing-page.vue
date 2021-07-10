<template>
  <div class="mt-10 flex flex-col">
    <!-- mensaje bienvenida -->
    <div class="flex flex-col items-center flex-none flex-grow-0 mb-4">
      <img
        class="h-28 w-28 pt-4 m-auto text-white"
        svg-inline
        src="../../assets/images/chef-svg.svg"
      >
      <h1 class="font-bold text-3xl text-gray-700 flex-none flex-grow-0 mb-1">
        {{ $t(`msg.welcomeTitle`) }}
      </h1>
      <h2 class="text-xl text-gray-700">
        {{ $t(`msg.welcomeSubtitle`) }}
      </h2>
    </div>
    <!-- form -->
    <div class="flex flex-col justify-center p-12 flex-none flex-grow-0 w-auto">
      <div
        v-if="isCurrentUser"
        class="flex flex-wrap justify-around p-4 mx-24"
      >
        <navegation-item
          :label="$t('msg.ingredients.title')"
          :active="activeElement==='ingredients'"
          img-src="ingredients-svg.svg"
          link="/ingredients"
        />

        <navegation-item
          :label="$t('msg.recipes.title')"
          :active="activeElement==='recipes'"
          img-src="recipes-svg.svg"
          link="/recipes"
        />

        <navegation-item
          :label="$t('msg.menus.title')"
          :active="activeElement==='menus'"
          img-src="menus-svg.svg"
          link="/menus"
        />

        <navegation-item
          :label="$t('msg.providers.title')"
          :active="activeElement==='providers'"
          img-src="providers-svg.svg"
          link="/providers"
        />
      </div>
      <div
        v-else
        class="w-full"
      >
        <p class="text-2xl text-gray-700 font-normal text-center p-2 mb-8">
          {{ $t('msg.start') }}
        </p>
        <div class="flex flex-col md:flex-row">
          <div class="w-48 p-1 mx-auto">
            <base-button
              :elements="{
                placeholder: $t('msg.users.login'),
                color: 'bg-green-500 hover:bg-green-700 text-white'
              }"
              @click="signIn"
            />
          </div>
          <div class="w-48 p-1 mx-auto">
            <base-button
              :elements="{
                placeholder: $t('msg.users.register'),
                color: 'bg-green-500 hover:bg-green-700 text-white'
              }"
              @click="signUp"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import NavegationItem from './home/navegation-item';

export default {
  props: {
    activeElement: { type: String, required: false, default: '' },
    isCurrentUser: { type: Boolean, required: true },
  },
  components: {
    NavegationItem,
  },
  methods: {
    signUp() {
      window.location = '/users/sign_up';
    },
    signIn() {
      window.location = '/users/sign_in';
    },
  },
};
</script>
