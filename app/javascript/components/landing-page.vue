<template>
  <div>
    <h1 class="text-4xl pt-4 font-semibold font-normal text-center">
      {{ $t('msg.welcomeTitle') }}
    </h1>
    <p class="text-2xl font-normal text-center">
      {{ $t('msg.welcomeSubtitle') }}
    </p>
    <img
      class="h-32 w-32 pt-4 m-auto text-white"
      svg-inline
      src="../../assets/images/chef-svg.svg"
    >

    <div
      v-if="isCurrentUser"
      class="flex flex-wrap justify-around p-10 mx-24"
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
      class="p-10"
    >
      <p class="text-2xl font-normal text-center p-2">
        {{ $t('msg.start') }}
      </p>
      <div class="flex flex-col">
        <div class="w-1/4 m-auto p-1">
          <base-button
            :elements="{
              placeholder: $t('msg.users.login'),
              color: 'bg-white hover:bg-gray-300 text-black'
            }"
            @click="signIn"
          />
        </div>
        <div class="w-1/4 m-auto p-1">
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
