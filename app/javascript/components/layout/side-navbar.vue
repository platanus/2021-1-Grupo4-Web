<template>
  <div class="flex flex-col z-50 w-20 h-full bg-gray-800">
    <a href="/ingredients">
      <side-navbar-item
        :label="$t('msg.ingredients.title')"
        :active="activeElement==='ingredients'"
        img-src="ingredients-svg.svg"
      />
    </a>

    <a href="/recipes">
      <side-navbar-item
        :label="$t('msg.recipes.title')"
        :active="activeElement==='recipes'"
        img-src="recipes-svg.svg"
      />
    </a>

    <a href="/menus">
      <side-navbar-item
        :label="$t('msg.menus.title')"
        :active="activeElement==='menus'"
        img-src="menus-svg.svg"
      />
    </a>
    <a href="/providers">
      <side-navbar-item
        :label="$t('msg.providers.title')"
        :active="activeElement==='providers'"
        img-src="providers-svg.svg"
      />
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
