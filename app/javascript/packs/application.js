import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import '../css/application.css';

import Locales from '../locales/locales.js';

import BaseButton from '../components/base/base-button.vue';
import BaseModal from '../components/base/base-modal.vue';
import BaseTable from '../components/base/base-table.vue';
import DotsDropdown from '../components/base/dots-dropdown.vue';

import TopNavbar from '../components/layout/top-navbar.vue';
import SideNavbar from '../components/layout/side-navbar.vue';
import SideNavbarItem from '../components/layout/side-navbar-item.vue';

import Register from '../components/users/register.vue';
import Login from '../components/users/login.vue';

import LandingPage from '../components/landing-page.vue';

import IngredientsContainer from '../components/ingredients/ingredients-container.vue';
import RecipesContainer from '../components/recipes/index/recipes-container.vue';
import RecipeShow from '../components/recipes/show/recipe-show.vue';
import MenusContainer from '../components/menus/index/menus-container.vue';

import RecipeInfo from '../components/recipes/show/base-recipe-info.vue';
import RecipeIngredients from '../components/recipes/show/base-recipe-ingredients.vue';
import RecipeIngredient from '../components/recipes/show/base-recipe-ingredient.vue';
import RecipeInstructions from '../components/recipes/show/base-recipe-instructions.vue';
import InstructionStep from '../components/recipes/show/base-instruction-step.vue';

Vue.use(VueI18n);

Vue.component('BaseButton', BaseButton);
Vue.component('BaseTable', BaseTable);
Vue.component('BaseModal', BaseModal);
Vue.component('DotsDropdown', DotsDropdown);

Vue.component('TopNavbar', TopNavbar);
Vue.component('SideNavbar', SideNavbar);
Vue.component('SideNavbarItem', SideNavbarItem);

Vue.component('Register', Register);
Vue.component('Login', Login);

Vue.component('LandingPage', LandingPage);

Vue.component('IngredientsContainer', IngredientsContainer);
Vue.component('RecipesContainer', RecipesContainer);
Vue.component('RecipeShow', RecipeShow);
Vue.component('MenusContainer', MenusContainer);

Vue.component('RecipeInfo', RecipeInfo);
Vue.component('RecipeIngredients', RecipeIngredients);
Vue.component('RecipeIngredient', RecipeIngredient);
Vue.component('RecipeInstructions', RecipeInstructions);
Vue.component('InstructionStep', InstructionStep);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    i18n: new VueI18n({
      locale: 'es',
      messages: Locales.messages,
    }),
  });

  return app;
});
