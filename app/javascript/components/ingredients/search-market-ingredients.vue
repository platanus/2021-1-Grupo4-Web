<template>
  <div class="pt-3 h-full w-96">
    <div>
      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="ingredient-name"
          >
            {{ $t('msg.ingredients.name') }}
          </label>
          <div class="flex w-full">
            <input
              class="appearance-none block w-1/2 bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none"
              id="ingredient-name"
              type="text"
              :placeholder="$t('msg.ingredients.name')"
              v-model="query"
              @keyup.enter="searchIngredients"
            >
            <span
              v-if="!loading"
              class="flex pl-2"
            >
              <button
                @click="searchIngredients"
                class="p-1 focus:outline-none focus:shadow-outline"
              >
                <img
                  svg-inline
                  src="../../../assets/images/magnifyng-glass-svg.svg"
                  class="w-8 h-8 text-yellow-700"
                >
              </button>
            </span>
            <div
              class="p-1"
              v-else
            >
              <span
                class="flex my-auto w-8 h-8 pl-2"
              >
                <base-spinner />
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div>
      <div class="pb-2">
        <select
          v-model="market"
          :disabled="loading"
          class="block w-2/3 bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight text-gray-700 focus:outline-none disabled:opacity-30"
        >
          <option
            :value="null"
            disabled
          >
            {{ $t('msg.ingredients.selectMarket') }}
          </option>
          <option
            v-for="(name, idx) in markets"
            :value="idx"
            :key="idx"
          >
            {{ name }}
          </option>
        </select>
      </div>
      <div
        v-if="!loading && market !== null"
        class="flex flex-wrap"
      >
        <div
          class="flex flex-col justify-center text-center p-3 w-1/2"
          v-for="(product, idx) in products"
          :key="idx"
        >
          <market-ingredient
            :img-url="product.imgUrl"
            :name="product.name"
            :price="product.price"
            :package-description="product.package"
            @submit="addMarketIngredient(idx)"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { searchCornershopIngredients } from '../../api/ingredients';
import MarketIngredient from './market-ingredient.vue';

export default {
  data() {
    return {
      loading: false,
      status: null,
      error: '',
      query: '',
      productsByMarket: [],
      market: null,
    };
  },
  components: {
    MarketIngredient,
  },
  methods: {
    async searchIngredients() {
      this.loading = true;
      try {
        const {
          data: { data },
        } = await searchCornershopIngredients(this.query);
        this.productsByMarket = data;
        this.market = 0;
      } catch (error) {
        this.errorResponse(error);
      } finally {
        this.loading = false;
      }
    },
    addMarketIngredient(productIdx) {
      const productInfo = this.productsByMarket[this.market].products[productIdx];
      const productForm = {
        provider_name: this.productsByMarket[this.market].provider.name, /* eslint-disable-line camelcase */
        name: productInfo.name,
        sku: null,
        price: productInfo.price,
        currency: 'CLP',
        ingredientMeasuresAttributes: [ /* eslint-disable-line camelcase */
          { name: productInfo.measure, quantity: 1 }],
      };
      this.$emit('submit', productForm);
    },
    async errorResponse(error) {
      this.status = error.response.status;
      this.error = error;
    },
  },
  computed: {
    markets() {
      return this.productsByMarket.map((market) => market.provider.name);
    },
    products() {
      if (this.market === null || this.productsByMarket.length === 0) return [];

      return this.productsByMarket[this.market].products;
    },
  },
};

</script>
