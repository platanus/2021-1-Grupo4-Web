import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import '../css/application.css';

import TopNavbar from '../components/layout/top-navbar-component.vue';
import SideNavbar from '../components/layout/side-navbar-component.vue';
import Ingredients from '../components/ingredients/base-component.vue';
import Item from '../components/layout/side-navbar-item-component.vue';
import Dropdown from '../components/ingredients/base-dropdown-component.vue';
import BaseButton from '../components/base/base-button-component.vue';
import InputForm from '../components/ingredients/base-input-form.vue';
import Search from '../components/base/base-search-component.vue';
import BaseTable from '../components/base/base-table-component.vue';
import BaseModal from '../components/base/base-modal-component.vue';
import IngredientsForm from '../components/ingredients/base-form-component';
import Register from '../components/users/register-component.vue';
import Login from '../components/users/login-component.vue';

import Locales from '../locales/locales.js';

Vue.use(VueI18n);

Vue.component('TopNavbar', TopNavbar);
Vue.component('SideNavbar', SideNavbar);
Vue.component('Ingredients', Ingredients);
Vue.component('Item', Item);
Vue.component('Dropdown', Dropdown);
Vue.component('BaseButton', BaseButton);
Vue.component('InputForm', InputForm);
Vue.component('Search', Search);
Vue.component('BaseTable', BaseTable);
Vue.component('BaseModal', BaseModal);
Vue.component('IngredientsForm', IngredientsForm);
Vue.component('Register', Register);
Vue.component('Login', Login);

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
