<template>
  <div
    class="fixed z-10 inset-0 overflow-y-auto"
    aria-labelledby="modal-title"
    role="dialog"
    aria-modal="true"
  >
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <div
        class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
        aria-hidden="true"
      />
      <span
        class="hidden sm:inline-block sm:align-middle sm:h-screen"
        aria-hidden="true"
      >&#8203;</span>
      <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
        <!--Título-->
        <div class="bg-gray-900 px-6 py-6 sm:px-6 sm:flex sm:flex-row">
          <h3
            class="text-lg leading-6 font-medium text-white"
            id="modal-title"
          >
            {{ title }}
          </h3>
        </div>

        <!--Contenido-->
        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
          <div class="sm:flex sm:items-start">
            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
              <div class="mt-2">
                <slot />
              </div>
            </div>
          </div>
        </div>

        <!--Botones-->
        <div class="bg-white px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
          <base-button
            :elements="{ placeholder: okButtonLabel, color: 'bg-green-500 hover:bg-green-700 text-white'}"
            @click="ok"
          />
          <base-button
            :elements="{ placeholder:cancelButtonLabel, color: 'bg-white hover:bg-gray-300 text-black'}"
            @click="cancel"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import BaseButton from './base-button-component.vue';
export default {
  components: {
    BaseButton,
  },
  props: {
    title: { type: String, required: true },
    okButtonLabel: { type: String, required: true },
    cancelButtonLabel: { type: String, required: true },
  },
  methods: {
    ok() {
      this.$emit('ok');
    },
    cancel() {
      this.$emit('cancel');
    },
  },
};
</script>
