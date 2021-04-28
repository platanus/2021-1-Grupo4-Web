import Vue from "vue/dist/vue.esm";
import "../css/application.css";

Vue.component("top-navbar", () =>
  import("../components/layout/top-navbar-component.vue")
);
Vue.component("side-navbar", () =>
  import("../components/layout/side-navbar-component.vue")
);
Vue.component("ingredients", () =>
  import("../components/ingredients/base-component.vue")
);
Vue.component("item", () =>
  import("../components/layout/side-navbar-item-component.vue")
);
Vue.component("dropdown", () =>
  import("../components/ingredients/base-dropdown-component.vue")
);
Vue.component("base-button", () =>
  import("../components/base/base-button-component.vue")
);
Vue.component("input-form", () =>
  import("../components/ingredients/base-input-form.vue")
);
Vue.component("search", () =>
  import("../components/base/base-search-component.vue")
);
Vue.component("base-table", () =>
  import("../components/base/base-table-component.vue")
);
Vue.component("base-modal", () =>
  import("../components/base/base-modal-component.vue")
);
Vue.component("ingredients-form", () =>
  import("../components/ingredients/base-form-component")
);
Vue.component("dropdown", () =>
  import("../components/ingredients/base-dropdown-component.vue")
);

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#vue-app"
  });

  return app;
});
