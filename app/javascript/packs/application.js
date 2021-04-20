import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';
import '../css/application.css';
import TopNavbar from '../components/top-navbar-component.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#vue-app',
    components: { App, TopNavbar },
  });

  return app;
});
