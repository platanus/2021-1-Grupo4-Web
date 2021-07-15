<template>
  <money
    v-bind="money"
    v-model="price"
    @input="handleInput"
  />
</template>

<script>
import { Money } from 'v-money';

export default {
  props: {
    value: { type: Number, required: false, default: 0 },
  },
  components: { Money },
  data() {
    return {
      price: this.value,
      money: {
        decimal: ',',
        thousands: '.',
        prefix: '$ ',
        precision: 0,
        masked: false,
      },
    };
  },
  methods: {
    handleInput() {
      this.$emit('input', this.price);
    },
  },
};
</script>

