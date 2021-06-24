<template>
  <div class="relative">
    <button
      class="focus:outline-none"
      @click="toggleDropdown"
    >
      <div class="flex justify-between items-center min-w-max w-16">
        <div> {{ selectedElement }} </div>
        <div>
          <img
            class="w-4 h-4"
            src="../../../assets/images/chevron-down-svg.svg"
          >
        </div>
      </div>
    </button>
    <div v-if="active">
      <div class="origin-top-right absolute mt-0.5 w-32 bg-white border overflow-visible rounded-lg shadow-md cursor-pointer z-10">
        <ul>
          <li
            v-for="element in elements"
            :key="element"
            class="hover:bg-gray-100"
          >
            <a
              class="font-semibold block px-4 py-3"
              @click="selectElement(element)"
            >
              {{ element }}
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    elements: { type: Array, required: true },
  },
  data() {
    return {
      active: false,
      selectedElement: this.elements[0],
    };
  },
  mounted() {
    document.addEventListener('click', this.closeDropdown);
  },
  unmounted() {
    document.removeEventListener('click', this.closeDropdown);
  },
  methods: {
    toggleDropdown() {
      this.active = !this.active;
    },
    closeDropdown(event) {
      if (event.target === this.$el || this.$el.contains(event.target)) return;
      this.active = false;
    },
    selectElement(element) {
      this.selectedElement = element;
      this.active = !this.active;
      this.$emit('select', this.selectedElement);
    },
  },
};
</script>
