import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';
import '../css/application.css';

import Locales from '../locales/locales.js';

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
import BaseSpinner from '../components/base/base-spinner-component.vue';
import IngredientsForm from '../components/ingredients/base-form-component';
import SearchMarketIngredients from '../components/ingredients/search-market-ingredients-component';
import MarketIngredient from '../components/ingredients/market-ingredient.vue';
import Register from '../components/users/register-component.vue';
import Login from '../components/users/login-component.vue';
import LandingPage from '../components/landing-page.vue';
import RecipesContainer from '../components/recipes/index/base-component.vue';
import SearchRecipe from '../components/recipes/index/base-search-recipe.vue';
import Recipes from '../components/recipes/index/base-recipes.vue';
import Recipe from '../components/recipes/index/base-recipe.vue';
import InfoRecipe from '../components/recipes/index/base-info-recipe.vue';
import PriceRecipe from '../components/recipes/index/base-price-recipe.vue';
import Pagination from '../components/recipes/index/base-pagination.vue';
import PageNumber from '../components/recipes/index/base-page-number.vue';
import FilterPopup from '../components/recipes/index/base-filter-popup.vue';

import RecipeShow from '../components/recipes/show/base-component.vue';
import RecipeInfo from '../components/recipes/show/base-recipe-info.vue';
import RecipeIngredients from '../components/recipes/show/base-recipe-ingredients.vue';
import RecipeIngredient from '../components/recipes/show/base-recipe-ingredient.vue';
import RecipeInstructions from '../components/recipes/show/base-recipe-instructions.vue';
import InstructionStep from '../components/recipes/show/base-instruction-step.vue';

import NewMenuContainer from '../components/menus/new/base-component.vue';
import MenusContainer from '../components/menus/index/base-component.vue';

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
Vue.component('BaseSpinner', BaseSpinner);
Vue.component('IngredientsForm', IngredientsForm);
Vue.component('SearchMarketIngredients', SearchMarketIngredients);
Vue.component('MarketIngredient', MarketIngredient);
Vue.component('Register', Register);
Vue.component('Login', Login);
Vue.component('LandingPage', LandingPage);
Vue.component('RecipesContainer', RecipesContainer);
Vue.component('SearchRecipe', SearchRecipe);
Vue.component('Recipes', Recipes);
Vue.component('Recipe', Recipe);
Vue.component('InfoRecipe', InfoRecipe);
Vue.component('PriceRecipe', PriceRecipe);
Vue.component('Pagination', Pagination);
Vue.component('PageNumber', PageNumber);
Vue.component('FilterPopup', FilterPopup);

Vue.component('RecipeShow', RecipeShow);
Vue.component('RecipeInfo', RecipeInfo);
Vue.component('RecipeIngredients', RecipeIngredients);
Vue.component('RecipeIngredient', RecipeIngredient);
Vue.component('RecipeInstructions', RecipeInstructions);
Vue.component('InstructionStep', InstructionStep);

Vue.component('NewMenuContainer', NewMenuContainer);
Vue.component('MenusContainer', MenusContainer);

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
