<template>
  <div>
    <button @click="openDropdown">
      <img
        svg-inline
        src="../../../assets/images/dropdown-svg.svg"
        class="h-6 w-6"
      >
    </button>
    <div v-if="active">
      <div class="origin-top-right absolute mt-0.5 w-32 bg-white border overflow-hidden rounded-lg shadow-md cursor-pointer">
        <ul>
          <li class="hover:bg-gray-100">
            <a
              class="font-semibold block px-4 py-3"
              v-if="elements.edit"
              @click="editIngredient"
            >{{ $t('msg.edit') }}</a>
          </li>
          <li class="hover:bg-gray-100">
            <a
              class="font-semibold block px-4 py-3"
              v-if="elements.del"
              @click="deleteIngredient"
            >{{ $t('msg.delete') }}</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Object, required: true },
  },
  data() {
    return {
      active: false,
    };
  },
  methods: {
    openDropdown() {
      this.active = !this.active;
    },
    editIngredient() {
      this.$emit('edit');
    },
    deleteIngredient() {
      this.$emit('del');
    },
  },
};
</script>
