import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import '../css/application.css';

import Locales from '../locales/locales.js';

import BaseButton from '../components/base/base-button.vue';
import BaseModal from '../components/base/base-modal.vue';
import BaseTable from '../components/base/base-table.vue';
import DotsDropdown from '../components/base/dots-dropdown.vue';
import BaseSpinner from '../components/base/base-spinner.vue';
import TextBox from '../components/base/base-text-box.vue';

import TopNavbar from '../components/layout/top-navbar.vue';
import SideNavbar from '../components/layout/side-navbar.vue';

import Register from '../components/users/register.vue';
import Login from '../components/users/login.vue';
import LandingPage from '../components/landing-page.vue';

import IngredientsContainer from '../components/ingredients/ingredients-container.vue';
import RecipesContainer from '../components/recipes/index/recipes-container.vue';
import RecipeShow from '../components/recipes/show/recipe-show.vue';
import RecipeEdit from '../components/recipes/edit/recipe-edit.vue';
import CreateRecipes from '../components/recipes/new/create-recipes.vue';
import MenusContainer from '../components/menus/index/menus-container.vue';
import NewMenuContainer from '../components/menus/new/new-menu-container.vue';

import formatCurrency from '../filters/format-currency.js';

Vue.use(VueI18n);

Vue.component('BaseTable', BaseTable);
Vue.component('BaseModal', BaseModal);
Vue.component('BaseButton', BaseButton);
Vue.component('DotsDropdown', DotsDropdown);
Vue.component('BaseSpinner', BaseSpinner);
Vue.component('TextBox', TextBox);

Vue.component('TopNavbar', TopNavbar);
Vue.component('SideNavbar', SideNavbar);

Vue.component('Register', Register);
Vue.component('Login', Login);
Vue.component('LandingPage', LandingPage);

Vue.component('IngredientsContainer', IngredientsContainer);
Vue.component('RecipesContainer', RecipesContainer);
Vue.component('RecipeShow', RecipeShow);
Vue.component('RecipeEdit', RecipeEdit);
Vue.component('CreateRecipes', CreateRecipes);
Vue.component('MenusContainer', MenusContainer);
Vue.component('NewMenuContainer', NewMenuContainer);

Vue.filter('currency', formatCurrency);

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
