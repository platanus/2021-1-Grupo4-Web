<template>
  <div class="pt-3">
    <form class="w-full max-w-lg">
      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <!--Name -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-name"
          >
            {{ $t('msg.providers.name') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-name"
            type="text"
            :placeholder="$t('msg.providers.name')"
            v-model="form.name"
          >
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <!--Address -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-address"
          >
            {{ $t('msg.providers.address') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-address"
            type="text"
            :placeholder="$t('msg.providers.address')"
            v-model="form.address"
          >
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <!--Country -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-country"
          >
            {{ $t('msg.providers.country') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-country"
            type="text"
            :placeholder="$t('msg.providers.country')"
            v-model="form.country"
          >
        </div>
      </div>
    </form>
  </div>
</template>

<script>

export default {
  props: {
    editMode: { type: Boolean, required: true },
    provider: { type: Object, default() {
      return {};
    } },
  },

  data() {
    return {
      form: {
        name: '',
        address: '',
        country: '',
      },
    };
  },

  created() {
    const {
      name,
      address,
      country,
    } = this.provider;

    this.form = {
      name,
      address,
      country,
    };
  },

  //   computed: {
  //     formUnits() {
  //       if (!this.editMode) {
  //         return this.units;
  //       }

//       return this.units.filter(unit => unit !== this.ingredient.measure);
//     },
//   },
};

</script>
