<template>
  <div class="flex flex-col items-start pt-0 pl-0 pr-0 pb-8 absolute w-64 h-screen left-0 top-16 bg-gray-800">
    <a href="/ingredients">
      <side-navbar-item
        :label="$t('msg.ingredients.title')"
        :active="activeElement==='ingredients'"
      >
        <img
          class="h-5 w-5 text-white"
          svg-inline
          src="../../../assets/images/ingredients-svg.svg"
        >
      </side-navbar-item>
    </a>

    <a href="/recipes">
      <side-navbar-item
        :label="$t('msg.recipes.title')"
        :active="activeElement==='recipes'"
      >
        <img
          class="h-5 w-5 text-white"
          svg-inline
          src="../../../assets/images/recipes-svg.svg"
        >
      </side-navbar-item>
    </a>

    <a href="/menus">
      <side-navbar-item
        :label="$t('msg.menus.title')"
        :active="activeElement==='menus'"
      >
        <img
          class="h-5 w-5 text-white"
          svg-inline
          src="../../../assets/images/menus-svg.svg"
        >
      </side-navbar-item>
    </a>
    <a href="/providers">
      <side-navbar-item
        :label="$t('msg.providers.title')"
        :active="activeElement==='providers'"
      >
        <img
          class="h-5 w-5 text-white"
          svg-inline
          src="../../../assets/images/provider-svg.svg"
        >
      </side-navbar-item>
    </a>
  </div>
</template>

<script>
import SideNavbarItem from './side-navbar-item';

export default {
  components: {
    SideNavbarItem,
  },

  props: {
    activeElement: { type: String, required: true },
  },
};
</script>
