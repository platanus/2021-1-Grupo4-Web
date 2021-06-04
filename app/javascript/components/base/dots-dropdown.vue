<template>
  <div class="relative">
    <button
      class="focus:outline-none"
      @click="toggleDropdown"
    >
      <img
        svg-inline
        src="../../../assets/images/dropdown-svg.svg"
        class="h-6 w-6"
      >
    </button>
    <div v-if="active">
      <div class="origin-top-right absolute mt-0.5 w-32 bg-white border overflow-hidden rounded-lg shadow-md cursor-pointer z-10">
        <ul>
          <li class="hover:bg-gray-100">
            <a
              class="font-semibold block px-4 py-3"
              v-if="elements.edit"
              @click="editElement"
            >{{ $t('msg.edit') }}</a>
          </li>
          <li class="hover:bg-gray-100">
            <a
              class="font-semibold block px-4 py-3"
              v-if="elements.del"
              @click="deleteElement"
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
    toggleDropdown() {
      this.active = !this.active;
    },
    editElement() {
      this.$emit('edit');
      this.toggleDropdown();
    },
    deleteElement() {
      this.$emit('del');
      this.toggleDropdown();
    },
  },
};
</script>
