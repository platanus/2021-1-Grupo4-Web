import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';
import '../css/application.css';
import Navbar from '../components/top-navbar-component.vue';
import Ingredients from '../components/ingredients-component.vue';
import SideNavbar from '../components/side-navbar/side-navbar-component.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    components: { App, Navbar, Ingredients, SideNavbar },
  });

  return app;
});
