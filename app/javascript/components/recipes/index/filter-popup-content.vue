<template>
  <div>
    <!-- Price Filters -->
    <p class="font-bold text-lg">
      {{ $t('msg.recipes.price') }}
    </p>
    <div class="flex">
      <div>
        <p>
          {{ $t('msg.min') }}
        </p>
        <input
          class="px-4 w-50 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
          :placeholder="$t('msg.min')"
          v-model="filters.price.min"
        >
        <base-error-paragraph
          :msg-error="errors.priceMin"
        />
      </div>
      <div class="ml-2">
        <p>
          {{ $t('msg.max') }}
        </p>
        <input
          class="px-4 w-50 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
          :placeholder="$t('msg.max')"
          v-model="filters.price.max"
        >
        <base-error-paragraph
          :msg-error="errors.priceMax"
        />
      </div>
    </div>

    <!-- Portion Filters -->
    <p class="font-bold text-lg mt-6">
      {{ $t('msg.recipes.portions') }}
    </p>
    <div class="flex">
      <div>
        <p>
          {{ $t('msg.min') }}
        </p>
        <input
          class="px-4 w-50 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
          :placeholder="$t('msg.min')"
          v-model="filters.portions.min"
        >
        <base-error-paragraph
          :msg-error="errors.portionsMin"
        />
      </div>
      <div class="ml-2">
        <p>
          {{ $t('msg.max') }}
        </p>
        <input
          class="px-4 w-50 h-12 bg-white border-2 border-solid border-gray-200 box-border rounded flex-grow-0 my-1"
          :placeholder="$t('msg.max')"
          v-model="filters.portions.max"
        >
        <base-error-paragraph
          :msg-error="errors.portionsMax"
        />
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: {
    actualfilters: { type: Object, required: true },
    errors: { type: Object, required: true },
  },
  data() {
    return {
      filters: this.actualfilters,
    };
  },
};
</script>
