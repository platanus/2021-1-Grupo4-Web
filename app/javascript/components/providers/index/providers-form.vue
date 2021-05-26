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
          <!--Correo -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-email"
          >
            {{ $t('msg.providers.email') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-email"
            type="text"
            :placeholder="$t('msg.providers.email')"
            v-model="form.email"
          >
          <!--Phone -->
        </div>
        <div class="relative">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-phone"
          >
            {{ $t('msg.providers.phone') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-phone"
            type="text"
            :placeholder="'+569'"
            v-model="form.phone"
          >
        </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <!--WebpageUrl -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-webpageUrl"
          >
            {{ $t('msg.providers.webpageUrl') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-webpageUrl"
            type="text"
            :placeholder="$t('msg.providers.webpageUrl')"
            v-model="form.webpageUrl"
          >
        </div>
        <div class="relative">
          <!--DeliberyDays -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-deliveryDays"
          >
            {{ $t('msg.providers.deliveryDays') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-deliveryDays"
            type="text"
            :placeholder="$t('msg.providers.deliveryDays')"
            v-model="form.deliveryDays"
          >
        </div>
      </div>
      <div class="flex flex-wrap -mx-3 mb-6">
        <div class="w-full px-3">
          <!--minimumPurchase -->
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="provider-minimumPurchase"
          >
            {{ $t('msg.providers.minimumPurchase') }}
          </label>
          <input
            class="appearance-none block w-full bg-white text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none"
            id="provider-minimumPurchase"
            type="text"
            :placeholder="$t('msg.providers.minimumPurchase')"
            v-model="form.minimumPurchase"
          >
        </div>
      </div>
    </form>
  </div>
</template>

<script>

export default {
  props: {
    provider: { type: Object, default() {
      return {};
    } },
  },

  data() {
    return {
      form: {
        name: '',
        email: '',
        wabpageUrl: '',
        minimumPurchase: '',
        deliveryDays: '',
        phone: '',
      },
    };
  },

  created() {
    const {
      name,
      email,
      wabpageUrl,
      minimumPurchase,
      deliveryDays,
      phone,
    } = this.provider;

    this.form = {
      name,
      email,
      wabpageUrl,
      minimumPurchase,
      deliveryDays,
      phone,
    };
  },
};

</script>
