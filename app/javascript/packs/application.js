import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import '../css/application.css';

import Locales from '../locales/locales.js';

import BaseButton from '../components/base/base-button.vue';
import BaseModal from '../components/base/base-modal.vue';
import DotsDropdown from '../components/base/dots-dropdown.vue';
import BaseDropdown from '../components/base/base-dropdown.vue';
import BaseSpinner from '../components/base/base-spinner.vue';
import TextBox from '../components/base/base-text-box.vue';
import BaseOneColumnTable from '../components/base/base-one-column-table';
import BaseErrorParagraph from '../components/base/base-error-paragraph';
import BaseAlert from '../components/base/base-alert';
import BaseMoney from '../components/base/base-money';
import BasePagination from '../components/base/base-pagination';

import TopNavbar from '../components/layout/top-navbar.vue';
import SideNavbar from '../components/layout/side-navbar.vue';

import Register from '../components/users/register.vue';
import Login from '../components/users/login.vue';
import ForgotPassword from '../components/users/forgot-password.vue';
import LandingPage from '../components/landing-page.vue';
import Profile from '../components/users/profile.vue';

import IngredientsContainer from '../components/ingredients/ingredients-container.vue';
import IngredientsEditInventory from '../components/ingredients/ingredients-edit-inventory.vue';
import RecipesContainer from '../components/recipes/index/recipes-container.vue';
import RecipeCreate from '../components/recipes/new/recipe-create.vue';
import RecipeShow from '../components/recipes/show/recipe-show.vue';
import RecipeEdit from '../components/recipes/edit/recipe-edit.vue';
import MenusContainer from '../components/menus/index/menus-container.vue';
import NewMenuContainer from '../components/menus/new/new-menu-container.vue';
import EditMenuContainer from '../components/menus/edit/edit-menu-container.vue';

import ProviderIndexContainer from '../components/providers/index/provider-index-component.vue';

import formatCurrency from '../filters/format-currency.js';

Vue.use(VueI18n);

Vue.component('BaseModal', BaseModal);
Vue.component('BaseButton', BaseButton);
Vue.component('DotsDropdown', DotsDropdown);
Vue.component('BaseDropdown', BaseDropdown);
Vue.component('BaseSpinner', BaseSpinner);
Vue.component('TextBox', TextBox);
Vue.component('BaseOneColumnTable', BaseOneColumnTable);
Vue.component('BaseErrorParagraph', BaseErrorParagraph);
Vue.component('BaseAlert', BaseAlert);
Vue.component('BaseMoney', BaseMoney);
Vue.component('BasePagination', BasePagination);

Vue.component('TopNavbar', TopNavbar);
Vue.component('SideNavbar', SideNavbar);

Vue.component('Register', Register);
Vue.component('Login', Login);
Vue.component('ForgotPassword', ForgotPassword);
Vue.component('LandingPage', LandingPage);
Vue.component('Profile', Profile);

Vue.component('IngredientsContainer', IngredientsContainer);
Vue.component('IngredientsEditInventory', IngredientsEditInventory);
Vue.component('RecipesContainer', RecipesContainer);
Vue.component('RecipeShow', RecipeShow);
Vue.component('RecipeEdit', RecipeEdit);
Vue.component('MenusContainer', MenusContainer);
Vue.component('NewMenuContainer', NewMenuContainer);
Vue.component('EditMenuContainer', EditMenuContainer);
Vue.component('RecipeCreate', RecipeCreate);

Vue.component('ProviderIndexContainer', ProviderIndexContainer);

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
