import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';
import '../css/application.css';
import TopNavbar from '../components/layout/top-navbar-component.vue';
import SideNavbar from '../components/layout/side-navbar-component.vue';
import Ingredients from '../components/ingredients/base-component.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    components: { App, TopNavbar, Ingredients, SideNavbar },
  });

  return app;
});
